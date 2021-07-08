import 'package:flutter/material.dart';
import 'package:todo/models/user.dart';
import 'package:get/get.dart';
class UserProfile extends StatelessWidget {
  final User? user;
  final Function? onLogout;
  const UserProfile({Key? key,  this.user, this.onLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        child:  Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).disabledColor,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user?.fullname ?? "please_login".tr,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context).accentColor
                        ),),
                      Text(user?.email ?? "", style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300
                      ),),
                    ],
                  ),

                ],
              ),
              if(onLogout !=null && user != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () => onLogout!(),
                    child: Text(
                      "sign_out".tr,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color:  Theme.of(context).colorScheme.error
                      ),
                    ),
                  ),
                )
            ],
          ),
        )
    );
  }
}
