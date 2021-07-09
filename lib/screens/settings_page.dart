import 'package:flutter/material.dart';
import 'package:todo/components/app_banner.dart';
import 'package:todo/components/brand/app_title.dart';
import 'package:get/get.dart';
import 'package:todo/components/cards/user_profile.dart';
import 'package:todo/components/navigations/subpage_app_bar.dart';
import 'package:todo/constants/text_styles.dart';
import 'package:todo/screens/auth/login_page.dart';
import 'package:todo/services/auth_service.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final AuthService authService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.authService = Get.find<AuthService>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  SubPageAppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .15,
        title: "Settings",
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
                    print("logout");

                    bool? logout = await showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: Text("logout".tr),
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

              Text("language".tr, style: kSectionTitle,),

            ],
          ),
        ),
      )

    );
  }
}
