import 'package:flutter/material.dart';

import '../cubit/cubit.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),

    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black54,
      ),
      headline1: TextStyle(
        fontSize: 25,
        color: Colors.deepOrange,
        fontWeight: FontWeight.w600,
      ),
      headline4: TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
      bodyText2: TextStyle(color: Colors.grey),
    ),

    // Theme of form TextField
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.black12),
      labelStyle: TextStyle(color: Colors.black54),
      fillColor: Colors.black12,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black26, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),

    // Theme of Listview
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black38,
      textColor: Colors.black54,
    ),

    // Theme of dividerTheme
    dividerTheme: const DividerThemeData(color: Colors.black54),

    // color of contacts item frame
    shadowColor: Colors.grey,
  );
}
