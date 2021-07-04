import 'package:flutter/material.dart';
// Since Scaffold require appBar property to be an interface of PreferredSizeWidget, an override for preferredSize property is required

class AppBanner extends StatefulWidget implements PreferredSizeWidget {
  final Color? fromColor; // gradient fromColor property
  final Color? toColor; // gradient toColor property
  final double? toolbarHeight;
  final Widget? header; // header widget slot
  final Widget? content; // content widget slot
  final Widget? bottom; // bottom widget slot
  final double? toolbarWidth ;
   AppBanner({Key? key, this.fromColor, this.toColor, this.toolbarHeight, this.header, this.content, this.bottom, this.toolbarWidth}) : super(key: key);
  Size get preferredSize {
    return Size(
      this.toolbarWidth ?? double.infinity, // if there is a toolbarWidth specify in named arguments, we will take that, else fallback to default value
      this.toolbarHeight ?? kToolbarHeight
    );
  }

  @override
  _AppBannerState createState() => _AppBannerState();
}

class _AppBannerState extends State<AppBanner> {
  


  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.from([]);
    if (widget.header != null ) {
      children.add(widget.header!);
    }

    if (widget.content != null){
      children.add(SizedBox(height: 15,));
      children.add(widget.content!);
    }

    if (widget.bottom != null){
      children.add(SizedBox(height: 15,));
      children.add(widget.bottom!);
    }
    return  SafeArea(
      child: PreferredSize(child: Wrap(

        direction: Axis.horizontal,
        children: [
          Container(
              constraints: BoxConstraints(
                  maxWidth: widget.preferredSize.width,
                minHeight: widget.preferredSize.height
              ),
              width: widget.preferredSize.width,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25)
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.fromColor ?? Color(0xFF03DAC5),
                        widget.toColor ?? Color(0xFF83D4FF),
                      ]
                  )
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children
              )
          )
        ],
      ), preferredSize: widget.preferredSize),
    );
  }
}