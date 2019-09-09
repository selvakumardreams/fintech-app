import 'package:fintech_app/login_page.dart';
import 'package:fintech_app/signup_page.dart';
import 'package:flutter/material.dart';


import 'login_page.dart';
import 'home_page.dart';
import 'signup_page.dart';
import 'transaction.dart';
import 'card_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
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
      home: LoginPage(),
      routes: routes,
    );
  }
}

