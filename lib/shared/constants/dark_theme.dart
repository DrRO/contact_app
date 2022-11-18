import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../cubit/cubit.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
      scaffoldBackgroundColor: HexColor('333739'),
      primarySwatch: Colors.deepOrange,
      // AppBar Theme
      appBarTheme: AppBarTheme(
          // Icon Theme
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: HexColor('333739'),

          elevation: 1.0,
          //Text theme
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        headline1: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        headline4: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        bodyText2: TextStyle(color: Colors.grey),
      ),
      // Theme of form TextField
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.grey),
        fillColor: Colors.white10,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white10, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),

      // Theme of Listview
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.white30,
        textColor: Colors.white54,
      ),
      dividerTheme: const DividerThemeData(color: Colors.grey),
      // color of contact item frame
      shadowColor: Colors.white70);
}
