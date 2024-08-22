import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:shopping/shared/styles/colors.dart';

ThemeData darkTheme=ThemeData(//هاد dart
  primarySwatch: Colors.deepOrange,//لون ال بريغراس
  scaffoldBackgroundColor:HexColor('333739'),
  appBarTheme:  AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(//هاد بيتحكم ب statusBar
        statusBarColor: HexColor('333739'),// color line
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor:HexColor('333739'),
      elevation: 0.0,
      iconTheme:const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle:const TextStyle(//لون العنوان
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      )
  ),//ينطبق على الاتطبيق كلو
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
  ),
  textTheme:const TextTheme(//لون النصوص
    titleMedium:TextStyle(
      fontSize: 18.0,
      fontWeight:FontWeight.bold,
      color: Colors.white,
    ),
  ),

);
ThemeData lightTheme=ThemeData(
  // primarySwatch: ,
  primarySwatch:defaultColor,//لون ال بريغراس
  scaffoldBackgroundColor:Colors.white,//لون ال شاشة
  appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      //  actionsIconTheme:IconThemeData(
      //  color: Colors.black,
      // ),
      systemOverlayStyle:SystemUiOverlayStyle(//هاد بيتحكم ب statusBar
        statusBarColor: Colors.white,// color line
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme:IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle:TextStyle(//لون العنوان
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      )
  ),//ينطبق على الاتطبيق كلو
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor:Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
  ),


  floatingActionButtonTheme:const FloatingActionButtonThemeData(
  backgroundColor: Colors.blueAccent,
  ),
);