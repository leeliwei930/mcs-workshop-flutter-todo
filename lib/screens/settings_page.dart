import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo/components/cards/user_profile.dart';

import 'package:todo/components/forms/password_form.dart';
import 'package:todo/components/navigations/subpage_app_bar.dart';
import 'package:todo/constants/text_styles.dart';
import 'package:todo/exceptions/form_exception.dart';
import 'package:todo/exceptions/toast_exception.dart';
import 'package:todo/models/password_form_data.dart';
import 'package:todo/models/user.dart';
import 'package:todo/screens/auth/login_page.dart';
import 'package:todo/services/auth_service.dart';
import 'package:todo/services/setting_service.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final AuthService authService;
  late final SettingService settingService;
  FormError? formError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.authService = Get.find<AuthService>();
    this.settingService = Get.find<SettingService>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  SubPageAppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .15,
        title: "settings".tr,
        onBack: (){
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("profile".tr, style: kSectionTitle,),
              SizedBox(height:15),
              Obx(() => UserProfile(
                  user: authService.user(),
                  onLogout: () async {

                    bool? logout = await showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: Text("log_out".tr),
                        content: Text("logout_message".tr),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text("yes".tr,
                              style: Theme.of(context).textTheme.button!.copyWith(
                                color: Colors.redAccent
                              ),
                            ),

                          ),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text("no".tr,
                                style: Theme.of(context).textTheme.button!.copyWith(
                                    color: Theme.of(context).accentColor
                                ),)
                          )
                        ],
                      );
                    });
                    if(logout ?? false){
                      await authService.logout();
                      Get.off(
                          () => LoginPage()
                      );
                    }
                  },
              )),
              SizedBox(height:20),
              Text("password_security".tr, style: kSectionTitle,),
              SizedBox(height:15),
              Obx(() => PasswordForm(
                formError: formError,
                isLoading: authService.isUpdatePasswordLoading(),
                submitButtonText: "update_password".tr,
                onSubmit:  handleChangePassword,
              ),),
              SizedBox(height:20),
              Text("language".tr, style: kSectionTitle,),
              buildLanguageSettingsForm(context)
            ],
          ),
        ),
      )

    );
  }

  void handleChangePassword(PasswordFormData formData) async {
    try {
     User user = await authService.changePassword(formData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("password_updated"))
      );
    } catch (error) {
      if(error is FormException){
        this.formError = error.formError;
      }
      toastException(error, context);
    }

  }

  Widget buildLanguageSettingsForm(BuildContext context){
    return Column(
      children: [
        RadioListTile<String>(
            groupValue: settingService.languageCode,
            title: Text("based_on_system_lang".tr),
            value: "system",
            onChanged: (newLang) => settingService.updateLanguage(Locale(newLang!))
        ),
        RadioListTile<String>(
            groupValue: settingService.languageCode,
            title: Text("中文"),
            value: "zh",
            onChanged: (newLang) => settingService.updateLanguage(Locale(newLang!))
        ),
        RadioListTile<String>(
            groupValue: settingService.languageCode,
            title: Text("English Global"),
            value: "en",
            onChanged: (newLang) => settingService.updateLanguage(Locale(newLang!))
        )
      ],
    );
  }
}
