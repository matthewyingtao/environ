import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';

class ShutterButtonBar extends StatelessWidget {
  final VoidCallback onPressed;

  const ShutterButtonBar({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          RawMaterialButton(
            elevation: 4.0,
            child: const Icon(
              Icons.camera_alt,
              color: themeGreen,
              size: 36.0,
            ),
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
            shape: const CircleBorder(
              side: BorderSide(
                color: themeGreen,
                width: 4,
              ),
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
