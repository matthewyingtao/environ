import 'package:flutter/material.dart';
import 'package:environ/shared/constants.dart';

class WideStadiumButton extends StatefulWidget {
  const WideStadiumButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  _WideStadiumButtonState createState() => _WideStadiumButtonState();
}

class _WideStadiumButtonState extends State<WideStadiumButton> {
  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: roundedButtonWhite,
        onPressed: widget.onPressed,
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 24,
          ),
          child: Text(widget.text),
        ),
      );
}
