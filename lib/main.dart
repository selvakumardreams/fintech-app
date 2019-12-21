import 'package:diafcon/login_page.dart';
import 'package:diafcon/signup_page.dart';
import 'package:flutter/material.dart';


import 'introscreen.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'signup_page.dart';
import 'transaction.dart';
import 'card_page.dart';

String deviceTheme = "light";

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue[700],
  primaryColorLight: Colors.blueAccent,
  accentColor: Colors.blueAccent,
);

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[700],
    primaryColorLight: Colors.grey[850],
    accentColor: Colors.blue,
    textSelectionHandleColor: Colors.blue);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    IntroScreenMainPage.tag: (context) => IntroScreenMainPage(),
    HomePage.tag: (context) => HomePage(),
    SignUpPage.tag: (context) => SignUpPage(),
    TransactionPage.tag: (context) => TransactionPage(),
    CardWidget.tag: (context) => CardWidget(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinTech App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: IntroScreenMainPage(),
      routes: routes,
    );
  }
}

