import 'package:brewcrew/shared/components/wide_stadium_button.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

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

  void signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
      if (result == null) {
        setState(() {
          error = "Something went wrong.";
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
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
                        decoration: textInputDecoration.copyWith(
                          icon: Icon(Icons.email_rounded),
                          labelText: 'Email',
                        ),
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
                          icon: Icon(Icons.vpn_key_rounded),
                          labelText: 'Password',
                        ),
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
                      WideStadiumButton(
                        text: "Sign In",
                        onPressed: signIn,
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
                          style: linkButtonStyle,
                        ),
                        onPressed: () {
                          widget.toggleView();
                        },
                      )
                    ],
                  ),
                )),
          );
  }
}
