import 'package:brewcrew/screens/authenticate/sign_in.dart';
import 'package:brewcrew/screens/authenticate/register.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  Widget screenWidget;
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
    if (screenWidget == null) {
      screenWidget = SignIn(toggleView: toggleView);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: leafSize),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            builder: (BuildContext context, double size, Widget widget) {
              return Transform.scale(
                alignment: Alignment.topLeft,
                scale: size,
                child: Opacity(
                  opacity: 0.05,
                  child: Transform(
                    transform: Matrix4.rotationZ(pi / 12.0),
                    child: SvgPicture.asset("assets/leavesbg.svg"),
                  ),
                ),
              );
            },
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: screenWidget,
          ),
        ],
      ),
    );
  }
}
