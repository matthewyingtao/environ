import 'package:environ/screens/home/home.dart';
import 'package:environ/screens/onboarding/onboarding.dart';
import 'package:environ/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<bool> isFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isFirstTime = prefs.getBool('first_time');

    if (isFirstTime == null || isFirstTime == true) {
      PermissionStatus status = await Permission.camera.status;
      if (status == PermissionStatus.denied) {
        await Permission.camera.request();
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isFirstTime(),
      builder: (context, isFirstTimeSnapshot) {
        if (isFirstTimeSnapshot.hasData && !isFirstTimeSnapshot.hasError) {
          if (isFirstTimeSnapshot.data!) {
            return const Onboarding();
          } else {
            return const Home();
          }
        } else {
          return const Loading();
        }
      },
    );
  }
}
