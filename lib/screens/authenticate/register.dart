import 'dart:math';

import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                  bottom: -150,
                  child: Container(
                      width: 500,
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
                            "Register",
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
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = "Something went wrong.";
                                  });
                                }
                              }
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
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
                              "Already have an account? Sign in.",
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
