import 'package:flutter/material.dart';

const double fontSizeBody = 16.0;

var lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: Colors.grey[200],
    primaryColor: Colors.black,
    accentColor: Colors.green[600],
    cardColor: Colors.grey[300],
    dialogBackgroundColor: Colors.green[100],
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: Colors.greenAccent[400],
    ),
    buttonColor: Colors.lightGreenAccent,
    textTheme: TextTheme(
        title: TextStyle(
          color: Colors.black,
          fontFamily: 'Oswald',
        ),
        body1: TextStyle(
          color: Colors.black,
          fontFamily: 'Oswald',
          fontSize: fontSizeBody,
        )),
    iconTheme: IconThemeData(color: Colors.grey[700]));

var darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Colors.grey[850],
    primaryColor: Colors.blueGrey[700],
    accentColor: Colors.blueGrey[200],
    cardColor: Colors.grey[700],
    scaffoldBackgroundColor: Colors.grey[800],
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: Colors.blueGrey,
    ),
    buttonColor: Colors.lightBlue[700],
    textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontFamily: 'Oswald',
        ),
        body1: TextStyle(
          color: Colors.white,
          fontFamily: 'Oswald',
          fontSize: fontSizeBody,
        )),
    iconTheme: IconThemeData(color: Colors.white));
