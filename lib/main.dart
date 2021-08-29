import 'package:environ/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:environ/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void clear() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black26,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const Wrapper(),
    );
  }
}
