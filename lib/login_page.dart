import 'package:fintech_app/signup_page.dart';
import 'package:fintech_app/home_page.dart';
import 'package:fintech_app/card_page.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    final logoLabel = FlatButton(
      child: Text(
        'Diaxfcon',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30.0),
      ),
      onPressed: () {},
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
        hintText: 'Email',
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

     final createButton = FlatButton(
      child: Text(
        'Don\'t have an account? Sign up here',
        style: TextStyle(color: Colors.white,
            fontSize: 16,
          decoration: TextDecoration.underline
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(SignUpPage.tag);
      },
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(HomePage.tag);
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Text('Lets get Started', style: TextStyle(color: Colors.black)),
      ),
    );


    final forgotLabel = FlatButton(
      child: Text(
        'By logging in you agree to our Terms and Conditions and confirm that you\'ve read our Privacy Policy',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(CardWidget.tag);
      },
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 30, 126, 1.0),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logoLabel,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 10.0),
            loginButton,
            createButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
