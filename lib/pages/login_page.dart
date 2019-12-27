import 'package:diafcon/models/login.dart';
import 'package:diafcon/pages/login.dart';
import 'package:diafcon/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  static String tag = 'login-page';
  final Login login;

  const LoginPage({Key key, this.login}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logo = Image(
      image: AssetImage("assets/logo.jpg"),
      height: 60.0,
      fit: BoxFit.cover,
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: login.username,
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
      initialValue: 'somepassword',
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
        style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            decoration: TextDecoration.underline),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SignUpPage(),
          ),
        );
      },
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
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
/*                       Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpenseOverview(),
                ),
              ); */
      },
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 30, 126, 1.0),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
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
