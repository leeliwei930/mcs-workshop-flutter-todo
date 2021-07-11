import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:todo/constants/default_theme.dart';
class CountDownButton extends StatefulWidget {
  const CountDownButton({Key? key, required this.timeLeft, required this.waitingText, required this.readyText, required this.repeatText,  this.onPressed}) : super(key: key);
  final Duration timeLeft;
  final String waitingText;
  final String readyText;
  final String repeatText;
  final Function? onPressed;
  @override
  _CountDownButtonState createState() => _CountDownButtonState();
}

class _CountDownButtonState extends State<CountDownButton> {

  late Duration timeLeft;
  late bool hasPressedBefore = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.timeLeft = widget.timeLeft;
  }

  void init(){
    if(timeLeft.inSeconds > 0){
      startTimer();
    }

  }

  void startTimer(){
    this.timeLeft = widget.timeLeft;
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      this.timeLeft = this.timeLeft - Duration(seconds: 1);
      if(this.timeLeft.isNegative ){
        timer.cancel();
      } else {
        // refreshing the button text
        setState(() {
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: accentColor
        )
      ),
        onPressed: (timeLeft.inSeconds > 0  && hasPressedBefore) ? null : buttonHandler,
        child:  Text(buttonText, style: Theme.of(context).textTheme.button!.copyWith(color: accentColor))
    );
  }

  void buttonHandler(){
      this.hasPressedBefore = true;
      if(timeLeft.inSeconds > 0 && widget.onPressed != null){
        widget.onPressed!();
      }
      this.startTimer();
  }
  int get countDownText {
    return this.timeLeft.inSeconds;
  }
  String get buttonText {
    if(!hasPressedBefore){
      return widget.readyText;
    } else if (hasPressedBefore && timeLeft.inSeconds > 0){
      return "${widget.waitingText} (${countDownText}s)";
    } else {
      return widget.repeatText;
    }
  }
}
