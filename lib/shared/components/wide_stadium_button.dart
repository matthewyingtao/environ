import 'package:flutter/material.dart';
import 'package:brewcrew/shared/constants.dart';

class WideStadiumButton extends StatefulWidget {
  @override
  _WideStadiumButtonState createState() => _WideStadiumButtonState();

  WideStadiumButton({this.text, this.onPressed});

  final String text;
  final Function onPressed;
}

class _WideStadiumButtonState extends State<WideStadiumButton> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: ElevatedButton(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 24.0,
          ),
          child: Text(widget.text),
        ),
        style: roundedButtonWhite,
        onPressed: widget.onPressed,
      ),
    );
  }
}
