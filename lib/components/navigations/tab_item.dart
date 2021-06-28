import 'package:flutter/material.dart';
import 'package:todo/constants/text_styles.dart';
class TabItem extends StatefulWidget {
  final String title;
  final Function? onTap;
  final bool active;
  const TabItem({Key? key, required this.title, this.onTap, this.active = false}) : super(key: key);
  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem>  with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<TextStyle> textStyleTween;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250), reverseDuration: Duration(milliseconds: 250));


  }
  @override
  Widget build(BuildContext context) {
    this.textStyleTween = TextStyleTween(
        begin: kInactiveTabTextStyle,
        end: kActiveTabTextStyle.copyWith(color: Theme.of(context).accentColor )
    ).animate(animationController);
    this.animationController.addListener(() {
      setState(() {

      });
    });


    if(widget.active){
      this.animationController.forward();
    } else {
      this.animationController.reverse();
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => (widget.onTap != null) ? widget.onTap!() : null,
        child: Container(
          padding: EdgeInsets.all(5),

          child: Text(
            widget.title.toUpperCase(),
            style: textStyleTween.value,
          ),
        ),
      ),
    );
  }
}
