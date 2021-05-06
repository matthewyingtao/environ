import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const RoundedButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawMaterialButton(
        fillColor: Colors.black54,
        elevation: 0,
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
