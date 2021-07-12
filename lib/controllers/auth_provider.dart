
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:todo/models/register_form_data.dart';
import 'package:todo/models/password_form_data.dart';
class AuthProvider extends GetConnect {
  @override
  void onInit() {
    if(kDebugMode){
      httpClient.baseUrl = dotenv.env['STRAPI_DEBUG_ENDPOINT'];
    } else {
      httpClient.baseUrl = dotenv.env['STRAPI_PRODUCTION_ENDPOINT'];
    }

    httpClient.errorSafety = false;
  }

  void setHttpAuthorizationHeader(String token){
    httpClient.addRequestModifier((Request request) async {
      // Set the header
      request.headers['Authorization'] = "Bearer $token";
      return request;
    });
  }

  void unsetHttpAuthorizationHeader(){
    httpClient.addRequestModifier((Request request) async {
      // Set the header
      request.headers.remove('Authorization');
      return request;
    });
  }
  Future<Response> login({ identifier: String, password: String}) async {
    Map<String, String> body = {
      "identifier" : identifier,
      "password" : password
    };
    return post('/auth/local', body);
  }

  Future<Response> registerUsingEmail(RegisterFormData data) async {

    return post('/auth/local/register', data.toJson());
  }

  Future<Response> getUserUsingToken(String token){

    return get('/users/me', headers: {
      "Authorization" : "Bearer $token"
    });

  }

  Future<Response> changePassword(PasswordFormData formData){
    return post('/password/update', formData.toJson());
  }
}
