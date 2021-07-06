import 'package:flutter/material.dart';
import 'package:todo/constants/text_styles.dart';
import 'package:todo/constants/default_theme.dart';
class SubPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;
  final Icon leadingIcon;
  final String title;
  final String leadingTitle;
  final Function? onBack;

  const SubPageAppBar({
    Key? key,
    this.toolbarHeight = kToolbarHeight,
    this.leadingIcon = const Icon(Icons.arrow_back, color: accentColor,),
    this.title = "",
    this.onBack,
    this.leadingTitle = "BACK"
  }) : super(key: key);

  @override
  Size get preferredSize {
    return Size.fromHeight(toolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      leadingIcon,
                      SizedBox(width: 10,),
                      Text(leadingTitle, style: kAppTitleTextStyle.copyWith(color: accentColor, fontSize: 14),)
                    ],
                  ),
                ),
                Text(title, style: kAppTitleTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
