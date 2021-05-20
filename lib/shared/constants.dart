import 'package:flutter/material.dart';

const themeGreen = Color(0xff47A060);
const themeDarkGreen = Color(0xff30A350);
const themeBlue = Color(0xff3f90ea);
const themeRed = Color(0xffe46855);
const themeYellow = Color(0xffE3BC57);
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

const linkButtonStyle = const TextStyle(
  color: themeDarkGreen,
  fontSize: 18,
  decoration: TextDecoration.underline,
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

ButtonStyle roundedButtonWhite = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.black54),
  textStyle: MaterialStateProperty.all(
    TextStyle(
      fontFamily: "Montserrat",
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w900,
    ),
  ),
  shape: MaterialStateProperty.all(
    StadiumBorder(
      side: BorderSide(
        color: Colors.white,
        width: 4.0,
      ),
    ),
  ),
);

ThemeData appTheme = ThemeData(
  primaryColor: themeGreen,
  accentColor: Colors.green,
  backgroundColor: themeGreen,
  fontFamily: "Montserrat",
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w900,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(12.0, 12.0),
          color: Color.fromRGBO(0, 0, 0, 0.20),
        ),
      ],
    ),
    headline3: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w900,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(4, 4.0),
          blurRadius: 4.0,
          color: Color.fromRGBO(0, 0, 0, 0.25),
        ),
      ],
    ),
    headline5: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
    ),
  ),
);
