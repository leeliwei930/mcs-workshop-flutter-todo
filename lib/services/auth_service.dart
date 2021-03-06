import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:todo/controllers/auth_provider.dart';
import 'package:todo/exceptions/form_exception.dart';
import 'package:todo/models/register_form_data.dart';
import 'package:todo/models/password_form_data.dart';
import 'package:todo/models/user.dart';

class AuthService extends GetxService {

  late FlutterSecureStorage secureStore;
  late AuthProvider authProvider;
  late Rx<User?> user;
  RxBool isAuthenticated = false.obs;
  RxBool isLoading = false.obs;
  RxBool isUpdatePasswordLoading = false.obs;
  RxBool isRegisterLoading = false.obs;

  @override
  Future<AuthService> onInit()  async {
      // initialise Flutter secure storage
      this.secureStore =  new FlutterSecureStorage();
      // instantiate the auth provider
      this.authProvider = AuthProvider();
      // init auth provider
      this.authProvider.onInit();

      // check for existing JWT token that stored by flutter_secure_storage
      String? existingToken = await this.getExistingJWT();
      // temp tokenValidState
      bool tokenIsValid = false;

      if(existingToken != null){
        // try to exchange user info from JWT with server
        await getUserFromToken(existingToken).then((User user){
          // if exchange success, set the user to auth service
          this.user = user.obs;
          // mark token as valid
          tokenIsValid = true;
        }).catchError((error){
          tokenIsValid = false;
          // clear off the previous store token
          this.clearToken();
        });
      }

      if(tokenIsValid){
        this.isAuthenticated.value = true;
        // inject http authorization header with JWT in it into authProvider http client instance
        this.authProvider.setHttpAuthorizationHeader(existingToken!);
      }
      return this;
  }

  @override
  void onClose() {

  }

  @override
  void onReady() {

  }

  // read the JWT token
  Future<String?> getExistingJWT() async {
    return await this.secureStore.read(key: "todo_jwt");
  }

  Future<User> getUserFromToken(String token) async {
    try {
      Response response = await this.authProvider.getUserUsingToken(token);
      if(response.status.isOk){
        User user = User.fromJson(response.body);
        return Future.value(user);
      }
      // throw session expired error
      throw GetHttpException("session_expired");
    } catch (exception) {
      this.isAuthenticated.value = false;

      return Future.error(exception);
    }
  }

  Future<User> loginUsingPassword(String identifier, String password) async {

    this.isLoading.value = true;
    try {
      Response response = await this.authProvider.login(identifier: identifier, password: password);

      if(response.isOk){
        User user = User.fromJson(response.body['user']);
        await this.saveToken(response.body['jwt']);
        this.user = user.obs;
        this.isAuthenticated.value = true;
        this.isLoading.value = false;
        String? existingJWT = await this.getExistingJWT();
        if(existingJWT != null){
          this.authProvider.setHttpAuthorizationHeader(existingJWT);

        }

        return Future.value(user);
      }
      throw GetHttpException("incorrect_account_credentials");
    } catch(error) {
      this.isAuthenticated.value = false;
      this.isLoading.value = false;

      return Future.error(error);
    }
  }

  Future<void> logout() async {
    await this.clearToken();
    this.authProvider.unsetHttpAuthorizationHeader();
    this.user = null.obs;
  }
  Future<void> clearToken() async {
    this.isAuthenticated.value = false;

    await this.secureStore.delete(key: "todo_jwt");
  }

  Future<void> saveToken(String token) async {
    await this.secureStore.write(key: "todo_jwt", value: token);
  }

  Future<User> changePassword(PasswordFormData formData) async {

    try {

        this.isUpdatePasswordLoading.value = true;

        Response response = await this.authProvider.changePassword(formData);
        if(response.isOk){
          User user = User.fromJson(response.body['user']);
          await this.saveToken(response.body['jwt']);
          this.user.value = user;
          this.isUpdatePasswordLoading.value = false;

          return Future.value(user);
        } else if(response.statusCode ==  HttpStatus.badRequest){
          FormException exception = FormException("validation_exception");
          exception.formError.record(response.body['data']['errors']);
          throw exception;
        }
        throw GetHttpException("server_error");
      } catch (error){
        this.isUpdatePasswordLoading.value = false;
        return Future.error(error);
      }
  }


  Future<User> registerUsingEmail(RegisterFormData data) async {
    try {
      this.isRegisterLoading.value = true;
      Response response = await authProvider.registerUsingEmail(data);
      if(response.isOk){
        User user = User.fromJson(response.body['user']);
        this.isRegisterLoading.value = false;
        return Future.value(user);
      } else if(response.statusCode ==  HttpStatus.badRequest){
        FormException exception = FormException("validation_exception");
        exception.formError.record(response.body['data']['errors']);
        throw exception;
      }

      throw GetHttpException("server_error");

    } catch (error) {
      this.isRegisterLoading.value = false;
      return Future.error(error);
    }
  }
}
