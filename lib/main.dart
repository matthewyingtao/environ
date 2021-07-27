import 'package:environ/models/user_model.dart';
import 'package:environ/screens/wrapper.dart';
import 'package:environ/services/auth.dart';
import 'package:environ/shared/constants.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

Future<void> clear() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black26,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamProvider<UserModel?>.value(
        initialData: null,
        value: AuthService().user,
        catchError: (_, __) => null,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: const Wrapper(),
        ),
      );
}
