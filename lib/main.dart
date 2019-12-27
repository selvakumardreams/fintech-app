import 'package:diafcon/pages/home_page.dart';
import 'package:diafcon/pages/intro/introscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/category.dart';
import 'scoped_models/app_model.dart';

String deviceTheme = "light";
final FirebaseAuth _auth = FirebaseAuth.instance;

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

restartApp() {
  main();
}


class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _DiafconAppState();
  }
}

class _DiafconAppState extends State<MyApp> {
  AppModel _model;
  List<Category> categories = [];

  @override
  void initState() {
    _model = AppModel();
    categories.add(Category("1", "Bills", MdiIcons.fileDocument));
    _model.setPreferences("light", 'da', categories);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: _model,
      child: MaterialApp(
        title: 'FinTech App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          fontFamily: 'Nunito',
        ),
        // home: IntroScreenMainPage(),
        home: _authenticateUser(_model.loginUser, _model),
      ),
    );
  }
}


Widget _authenticateUser(Function loginUser, AppModel model) {
  return StreamBuilder<FirebaseUser>(
    stream: _auth.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return _buildSplashScreen();
      } else {
        if (snapshot.hasData) {
          dynamic user = snapshot.data;

          //Fetch User Data
          loginUser(user.displayName, user.uid, user.email, user.photoUrl);
          return HomePage();
        }
        return IntroScreenMainPage();
      }
    },
  );
}

Widget _buildSplashScreen() {
  return Scaffold(
    body: Center(
      child: Text("Loading..."),
    ),
  );
}

