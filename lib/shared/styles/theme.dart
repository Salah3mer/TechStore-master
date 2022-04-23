
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
ThemeData lightMood() =>
    ThemeData(
      primaryColor: Colors.lightBlue,
      backgroundColor:Colors.white,
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.0,
        ),
      ),
      // primarySwatch: Colors.blue,

      scaffoldBackgroundColor:Colors.grey.shade50,

      appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(

            color: Colors.black
        ),

        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,

        ),
        titleTextStyle: TextStyle(

          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,


        ),


      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.lightBlue,
        elevation: 0,
        type: BottomNavigationBarType.fixed,

      ),
    );

ThemeData darkMood() =>
    ThemeData(
      backgroundColor: HexColor('1e2336'),
      textTheme:const TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.0,
        ),
      ) ,
      primarySwatch: Colors.lightBlue,

      scaffoldBackgroundColor:HexColor('0e121a') ,

      appBarTheme: AppBarTheme(
        backgroundColor: HexColor('0e121a'),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('0e121a'),
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,

        ),
        titleTextStyle: const TextStyle(

          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,


        ),


      ),
      iconTheme: const IconThemeData(
          color: Colors.white
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(

          backgroundColor: HexColor('0e121a'),
          selectedItemColor: Colors.lightBlue,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey

      ),
    );