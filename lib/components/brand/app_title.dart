import 'package:flutter/material.dart';
import 'package:todo/constants/text_styles.dart';
class AppTitle extends StatelessWidget {

  final Color? color;
  const AppTitle({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.edit, color: this.color ?? Colors.white, size: 24,),
        SizedBox(
          width: 10,
        ),
        Text("Todo.", style: kAppTitleTextStyle.copyWith(color: Colors.white),)
      ],
    );
  }
}
