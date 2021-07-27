import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

class PopUpDialog extends StatelessWidget {
  final Widget bodyWidget;

  const PopUpDialog({required Widget this.bodyWidget, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: -40,
          left: -80,
          child: Transform(
            transform: Matrix4.rotationZ(pi / 12.0),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/leavesbg.svg",
              color: const Color.fromRGBO(0, 0, 0, 0.06),
              height: 360,
              width: 360,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
            child: this.bodyWidget,
          ),
        ),
      ],
    );
  }
}
