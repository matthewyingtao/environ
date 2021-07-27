import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopUpDialog extends StatelessWidget {
  const PopUpDialog({required this.bodyWidget, Key? key}) : super(key: key);

  final Widget bodyWidget;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Positioned(
            bottom: -40,
            left: -80,
            child: Transform(
              transform: Matrix4.rotationZ(pi / 12.0),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/leavesbg.svg',
                color: const Color.fromRGBO(0, 0, 0, 0.06),
                height: 360,
                width: 360,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: bodyWidget,
            ),
          ),
        ],
      );
}
