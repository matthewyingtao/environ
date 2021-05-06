import 'package:flutter/material.dart';

const Map<int, Color> themeGreen = {
  50: Color.fromRGBO(102, 191, 141, 0.05),
  100: Color.fromRGBO(102, 191, 141, 0.1),
  200: Color.fromRGBO(102, 191, 141, 0.2),
  300: Color.fromRGBO(102, 191, 141, 0.3),
  400: Color.fromRGBO(102, 191, 141, 0.4),
  500: Color.fromRGBO(102, 191, 141, 0.5),
  600: Color.fromRGBO(102, 191, 141, 0.6),
  700: Color.fromRGBO(102, 191, 141, 0.7),
  800: Color.fromRGBO(102, 191, 141, 0.8),
  900: Color.fromRGBO(102, 191, 141, 0.9),
  1000: Color(0xff7ebc91),
};
const themeDarkGreen = Color(0xff5A956D);
const themeBlue = Color(0xff3f90ea);
const themeRed = Color(0xffe46855);
const black = Color(0xff1e1e1e);
const black50 = Color(0x80000000);

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  hintStyle: TextStyle(
    color: Colors.black45,
    fontSize: 24,
  ),
  enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black45, width: 2.0)),
  focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: themeBlue, width: 2.0)),
);

const textButtonStyle = TextStyle(
  color: themeBlue,
  fontSize: 16,
);

double getElevation(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return 16;
  }
  return 8;
}

TextStyle getButtonTextStyle(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w900,
    );
  }
  return TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );
}

ThemeData appTheme = ThemeData(
    primaryColor: themeGreen[1000],
    accentColor: Colors.green,
    backgroundColor: themeGreen[100],
    fontFamily: "Montserrat",
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      backgroundColor: Colors.black54,
      shape: StadiumBorder(side: BorderSide(color: Colors.red)),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    )),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: black,
        fontWeight: FontWeight.w900,
        fontSize: 48,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(4.0, 4.0),
            blurRadius: 4.0,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ],
      ),
      bodyText2: TextStyle(),
    ));

const titleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
);
