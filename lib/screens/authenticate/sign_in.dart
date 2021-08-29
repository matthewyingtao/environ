import 'package:environ/shared/components/wide_stadium_button.dart';
import 'package:environ/shared/constants.dart';
import 'package:environ/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({
    required this.toggleView,
    Key? key,
  }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

void clear() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  void signIn() async {}

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : SafeArea(
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Sign In",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: black),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 48.0,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          icon: const Icon(Icons.email_rounded),
                          labelText: 'Email',
                        ),
                        validator: (val) =>
                            val!.isEmpty ? "Enter an email" : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      const SizedBox(
                        height: 48.0,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          icon: const Icon(Icons.vpn_key_rounded),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? "Enter a password 6+ chars long"
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      const SizedBox(
                        height: 48.0,
                      ),
                      WideStadiumButton(
                        text: "Sign In",
                        onPressed: signIn,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        error,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      TextButton(
                        child: const Text(
                          "New user? Register.",
                          style: linkButtonStyle,
                        ),
                        onPressed: () {
                          widget.toggleView();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          "Onboarding",
                          style: linkButtonStyle,
                        ),
                        onPressed: () {
                          clear();
                        },
                      ),
                    ],
                  ),
                )),
          );
  }
}
