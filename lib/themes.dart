import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData redTheme() {
    return new ThemeData(
      brightness: Brightness.dark,
      accentColorBrightness: Brightness.dark,
      primaryColor: Colors.red,
      primaryColorLight: Colors.red,
      primaryColorDark: Colors.red[700],
      scaffoldBackgroundColor: Colors.redAccent,
      indicatorColor: Colors.white,
      accentColor: Colors.black,
      cardColor: Colors.white60,
      toggleableActiveColor: Colors.black,
      fontFamily: 'Tomica',
    );
  }

  static ThemeData yellowTheme() {
    return new ThemeData(
        brightness: Brightness.dark,
        primaryColorDark: Colors.yellow[700],
        scaffoldBackgroundColor: Colors.yellow[600],
        accentColorBrightness: Brightness.dark,
        primaryColor: Colors.yellow[700],
//    primaryColorDark: const Color(0xFF0050a0),
        primaryColorLight: Colors.yellowAccent,
        indicatorColor: Colors.white,
//    toggleableActiveColor: const Color(0xFF6997DF),
        accentColor: Colors.black,
        cardColor: Colors.white60,
        toggleableActiveColor: Colors.black,
        fontFamily: 'Tomica'
//      canvasColor: const Color(0xFF202124),
//      scaffoldBackgroundColor: const Color(0xFF202124),
//      backgroundColor: const Color(0xFF202124),
        );
  }

  static ThemeData blueTheme() {
    return new ThemeData(
        brightness: Brightness.dark,
        primaryColorDark: Colors.blue[700],
        scaffoldBackgroundColor: Colors.blueAccent,
        accentColorBrightness: Brightness.dark,
        primaryColor: Colors.blue,
//    primaryColorDark: const Color(0xFF0050a0),
        primaryColorLight: Colors.blueAccent,
        indicatorColor: Colors.white,
//    toggleableActiveColor: const Color(0xFF6997DF),
        accentColor: Colors.black,
        cardColor: Colors.white60,
        toggleableActiveColor: Colors.black,
        fontFamily: 'Tomica'
//      canvasColor: const Color(0xFF202124),
//      scaffoldBackgroundColor: const Color(0xFF202124),
//      backgroundColor: const Color(0xFF202124),
        );
  }

  static ThemeData indigoTheme() {
    return new ThemeData(
        brightness: Brightness.dark,
        primaryColorDark: Colors.indigo[700],
        scaffoldBackgroundColor: Colors.indigoAccent,
        accentColorBrightness: Brightness.dark,
        primaryColor: Colors.indigo,
//    primaryColorDark: const Color(0xFF0050a0),
        primaryColorLight: Colors.indigoAccent,
        indicatorColor: Colors.white,
//    toggleableActiveColor: const Color(0xFF6997DF),
        accentColor: Colors.black,
        cardColor: Colors.white60,
        toggleableActiveColor: Colors.black,
        fontFamily: 'Tomica'
//      canvasColor: const Color(0xFF202124),
//      scaffoldBackgroundColor: const Color(0xFF202124),
//      backgroundColor: const Color(0xFF202124),
        );
  }

  static ThemeData greenTheme() {
    return new ThemeData(
        brightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primaryColorDark: Colors.green[700],
        scaffoldBackgroundColor: Colors.green,
        primaryColor: Colors.green,
//    primaryColorDark: const Color(0xFF0050a0),
        primaryColorLight: Colors.greenAccent,
        indicatorColor: Colors.white,
//    toggleableActiveColor: const Color(0xFF6997DF),
        accentColor: Colors.black,
        cardColor: Colors.greenAccent,
        toggleableActiveColor: Colors.black,
        fontFamily: 'Tomica'
//      canvasColor: const Color(0xFF202124),
//      scaffoldBackgroundColor: const Color(0xFF202124),
//      backgroundColor: const Color(0xFF202124),
        );
  }

  static ThemeData lightTheme() {
    return new ThemeData(
      brightness: Brightness.light,
      accentColor: Colors.grey,
      primaryColor: Colors.white,
      buttonColor: Colors.grey,
    );
  }

  static ThemeData darkTheme() {
    return new ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.grey,
      primaryColor: Colors.black,
      buttonColor: Colors.grey,
    );
  }

  static ThemeData blackTheme() {
    return new ThemeData(
      brightness: Brightness.dark,
      accentColorBrightness: Brightness.dark,
      primaryColorDark: Colors.black,
      primaryColor: Colors.black,
      primaryColorLight: Colors.grey,
      accentColor: Colors.grey,
      cardColor: Colors.white60,
      fontFamily: 'Tomica',
      toggleableActiveColor: Colors.black,
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
