import 'package:flutter/material.dart';

const themeGreen = Color(0xff47A060);
const themeDarkGreen = Color(0xff30A350);
const themeBlue = Color(0xff3f90ea);
const themeRed = Color(0xffe46855);
const themeYellow = Color(0xffE3BC57);
const black = Color(0xff1e1e1e);

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  hintStyle: TextStyle(
    color: Colors.white38,
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white54, width: 2),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white70, width: 2),
  ),
);

const linkButtonStyle = TextStyle(
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
    const TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w900,
    ),
  ),
  shape: MaterialStateProperty.all(
    const StadiumBorder(
      side: BorderSide(
        color: Colors.white,
        width: 4,
      ),
    ),
  ),
);

ThemeData appTheme = ThemeData(
  // color palette
  primaryColor: themeGreen,
  backgroundColor: themeGreen,
  splashColor: Colors.black45,
  highlightColor: Colors.black45,

  // typography
  fontFamily: 'Montserrat',
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 72,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(12, 12),
          color: Color.fromRGBO(0, 0, 0, 0.20),
        ),
      ],
    ),
    headline2: TextStyle(
      fontWeight: FontWeight.w700,
    ),
    headline3: TextStyle(
      fontWeight: FontWeight.w900,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(4, 4),
          blurRadius: 4,
          color: Color.fromRGBO(0, 0, 0, 0.25),
        ),
      ],
    ),
    headline4: TextStyle(
      fontWeight: FontWeight.w700,
    ),
    headline5: TextStyle(
      fontWeight: FontWeight.w700,
    ),
    headline6: TextStyle(
      fontWeight: FontWeight.w700,
    ),
    bodyText2: TextStyle(
      fontSize: 16,
      height: 1.4,
    ),
  ).apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
);
