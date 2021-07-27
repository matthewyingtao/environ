import 'package:environ/shared/components/wide_stadium_button.dart';
import 'package:environ/services/auth.dart';
import 'package:environ/shared/constants.dart';
import 'package:environ/shared/loading.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    required this.toggleView,
    Key? key,
  }) : super(key: key);

  final VoidCallback toggleView;

  @override
  _SignInState createState() => _SignInState();
}

Future<void> clear() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      final dynamic result =
          await _auth.signInWithEmailAndPassword(email, password);
      if (result is String) {
        setState(() {
          error = result;
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => loading
      ? const Loading()
      : SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: black),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        icon: const Icon(Icons.email_rounded),
                        labelText: 'Email',
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        icon: const Icon(Icons.vpn_key_rounded),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    WideStadiumButton(
                      text: 'Sign In',
                      onPressed: signIn,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.toggleView();
                      },
                      child: const Text(
                        'New user? Register.',
                        style: linkButtonStyle,
                      ),
                    ),
                    const TextButton(
                      onPressed: clear,
                      child: Text(
                        'Onboarding',
                        style: linkButtonStyle,
                      ),
                    ),
                  ],
                ),
              )),
        );
}
