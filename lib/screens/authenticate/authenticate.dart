import 'dart:math';

import 'package:environ/screens/authenticate/sign_in.dart';
import 'package:environ/screens/authenticate/register.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  Widget? screenWidget;
  double leafSize = 2;

  void toggleView() {
    setState(() {
      if (screenWidget is SignIn) {
        screenWidget = Register(toggleView: toggleView);
        leafSize = 1.5;
      } else {
        screenWidget = SignIn(toggleView: toggleView);
        leafSize = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidget ??= screenWidget = SignIn(toggleView: toggleView);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: leafSize),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            builder: (context, size, widget) => Transform(
              transform: Matrix4.rotationZ(pi / 12.0)..scale(size),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/leavesbg.svg',
                color: const Color.fromRGBO(0, 0, 0, 0.05),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: screenWidget,
          ),
        ],
      ),
    );
  }
}
