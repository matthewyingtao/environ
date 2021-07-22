import 'package:flutter/material.dart';
import 'package:environ/shared/constants.dart';

class WideStadiumButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  WideStadiumButton({
    required this.text,
    required this.onPressed,
  });

  @override
  _WideStadiumButtonState createState() => _WideStadiumButtonState();
}

class _WideStadiumButtonState extends State<WideStadiumButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24.0,
        ),
        child: Text(widget.text),
      ),
      style: roundedButtonWhite,
      onPressed: widget.onPressed,
    );
  }
}
