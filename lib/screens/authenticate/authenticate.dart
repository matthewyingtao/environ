import 'package:brewcrew/screens/authenticate/sign_in.dart';
import 'package:brewcrew/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  Widget screenWidget;

  void toggleView() {
    setState(() {
      if (screenWidget is SignIn) {
        screenWidget = Register(toggleView: toggleView);
      } else {
        screenWidget = SignIn(toggleView: toggleView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (screenWidget == null) {
      screenWidget = SignIn(toggleView: toggleView);
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: screenWidget,
    );
  }
}
