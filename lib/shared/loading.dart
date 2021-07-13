import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeGreen,
      child: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 64.0,
        ),
      ),
    );
  }
}
