import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final bool transparent;
  const Loading({this.transparent = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: transparent ? Colors.black54 : themeGreen,
      child: const Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 64.0,
        ),
      ),
    );
  }
}
