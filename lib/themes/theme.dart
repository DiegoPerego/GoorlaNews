import 'package:flutter/material.dart';

final appTheme = ThemeData(
  appBarTheme: AppBarTheme(color: Colors.white),
  textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Corben',
        fontWeight: FontWeight.w700,
        fontSize: 17,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.bold,
        fontSize: 17,
        color: Colors.black,
      ),
      subtitle2: TextStyle(
        fontFamily: 'Georgia',
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black,
      ),
      headline2: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.grey[700],
      )),
);

final searchAppTheme = ThemeData(
  primaryColor: Colors.white,
  textTheme: TextTheme(
    headline6: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15,
    ),
  ),
);
