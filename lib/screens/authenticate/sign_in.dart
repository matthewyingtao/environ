import 'dart:math';

import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:brewcrew/components/rounded_button.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Stack(children: [
              Positioned(
                  bottom: -100,
                  left: -200,
                  child: Container(
                      width: 700,
                      child: Opacity(
                          opacity: 0.15,
                          child: Transform(
                              transform: Matrix4.rotationZ(pi / 12.0),
                              child:
                                  SvgPicture.asset("assets/leavesbg.svg"))))),
              SafeArea(
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Sign In",
                            style: Theme.of(context).textTheme.headline1,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 48.0,
                          ),
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: "Email"),
                            validator: (val) =>
                                val.isEmpty ? "Enter an email" : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(
                            height: 48.0,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: "Password"),
                            obscureText: true,
                            validator: (val) => val.length < 6
                                ? "Enter a password 6+ chars long"
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(
                            height: 48.0,
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.7,
                            child: RoundedButton(
                              text: "Sign In",
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error = "Something went wrong.";
                                      loading = false;
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          TextButton(
                            child: Text(
                              "New user? Register.",
                              style: textButtonStyle,
                            ),
                            onPressed: () {
                              widget.toggleView();
                            },
                          )
                        ],
                      ),
                    )),
              )
            ]));
  }
}
