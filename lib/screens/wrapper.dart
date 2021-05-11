import 'package:brewcrew/screens/authenticate/authenticate.dart';
import 'package:brewcrew/screens/home/home.dart';
import 'package:brewcrew/screens/onboarding/onboarding.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<bool> isFirstTime() async {
    return true;
    // await new Future.delayed(const Duration(milliseconds: 500));
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    // var isFirstTime = prefs.getBool('first_time');
    // if (isFirstTime == null || true) {
    //   prefs.setBool('first_time', false);
    //   return true;
    // } else {
    //   return false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return FutureBuilder<bool>(
      future: isFirstTime(),
      builder: (BuildContext context, isFirstTimeSnapshot) {
        if (isFirstTimeSnapshot.hasData && !isFirstTimeSnapshot.hasError) {
          if (isFirstTimeSnapshot.data) {
            return Onboarding();
          } else {
            if (user == null) {
              return Authenticate();
            } else
              return Home();
          }
        } else {
          return Loading();
        }
      },
    );
  }
}
