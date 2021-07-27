import 'package:environ/shared/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({this.transparent = false, Key? key}) : super(key: key);

  final bool transparent;

  @override
  Widget build(BuildContext context) => Container(
        color: transparent ? Colors.black54 : themeGreen,
        child: const Center(
          child: SpinKitFoldingCube(
            color: Colors.white,
            size: 64,
          ),
        ),
      );
}
