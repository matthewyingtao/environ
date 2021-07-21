import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';

class ShutterButtonBar extends StatelessWidget {
  final Function? onPressed;

  ShutterButtonBar({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          RawMaterialButton(
            elevation: 4.0,
            child: Icon(
              Icons.camera_alt,
              color: themeGreen,
              size: 36.0,
            ),
            fillColor: Colors.white,
            padding: EdgeInsets.all(12.0),
            shape: CircleBorder(
              side: BorderSide(
                color: themeGreen,
                width: 4,
              ),
            ),
            onPressed: this.onPressed as void Function()?,
          ),
        ],
      ),
    );
  }
}
