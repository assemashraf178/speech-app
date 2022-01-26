import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode() => ThemeData(
      cardColor: Colors.white,
      cardTheme: const CardTheme(
        color: Color(0xff1C262F),
      ),
      primaryColor: const Color(0xff1C262F),
      dividerColor: Colors.grey,
      textTheme: const TextTheme(
        button: TextStyle(
          color: Colors.white,
        ),
        bodyText1: TextStyle(
          color: Colors.white,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
        ),
        headline6: TextStyle(
          color: Colors.white,
        ),
        headline1: TextStyle(
          color: Colors.white,
        ),
        headline2: TextStyle(
          color: Colors.white,
        ),
        headline3: TextStyle(
          color: Colors.white,
        ),
        headline4: TextStyle(
          color: Colors.white,
        ),
        headline5: TextStyle(
          color: Colors.white,
        ),
        overline: TextStyle(
          color: Colors.white,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff1C262F),
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xff1C262F),
          statusBarIconBrightness: Brightness.light,
        ),
        backwardsCompatibility: false,
        titleSpacing: 0.0,
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      fontFamily: 'Jannah',
      hintColor: Colors.grey[400],
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      splashColor: const Color(0xFF1B2C3B),
      scaffoldBackgroundColor: const Color(0xFF1B2C3B),
    );
