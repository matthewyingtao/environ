import 'package:environ/services/auth.dart';
import 'package:environ/shared/components/wide_stadium_button.dart';
import 'package:environ/shared/constants.dart';
import 'package:environ/shared/loading.dart';

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({
    required this.toggleView,
    Key? key,
  }) : super(key: key);

  final VoidCallback toggleView;

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

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      final dynamic result =
          await _auth.registerWithEmailAndPassword(email, password);
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
                      'Register',
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
                        icon: const Icon(Icons.email),
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
                      text: 'Register',
                      onPressed: register,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: TextButton(
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: const Text(
                          'Already have an account? Sign in.',
                          style: linkButtonStyle,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        );
}
