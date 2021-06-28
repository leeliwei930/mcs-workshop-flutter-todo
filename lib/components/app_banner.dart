import 'package:flutter/material.dart';

class AppBanner extends StatefulWidget implements PreferredSizeWidget {
  final Color? fromColor;
  final Color? toColor;
  final double? toolbarHeight;
  final Widget? header;
  final Widget? content;
  final Widget? bottom;
  final double? toolbarWidth ;
   AppBanner({Key? key, this.fromColor, this.toColor, this.toolbarHeight, this.header, this.content, this.bottom, this.toolbarWidth}) : super(key: key);
  Size get preferredSize {
    return Size(
      this.toolbarWidth ?? double.infinity,
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
    print(widget.preferredSize);
    return  SafeArea(
      child: PreferredSize(child: Flex(

        direction: Axis.horizontal,
        children: [
          Container(
              constraints: BoxConstraints(
                  maxWidth: widget.preferredSize.width
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
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children
              )
          )
        ],
      ), preferredSize: widget.preferredSize),
    );
  }
}