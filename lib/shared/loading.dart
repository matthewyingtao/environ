import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final bool transparent;
  Loading({this.transparent = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.transparent ? Colors.black54 : themeGreen,
      child: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 64.0,
        ),
      ),
    );
  }
}
