import 'package:flutter/material.dart';

import 'budget_intro.dart';
import 'dots_indicator.dart';
import 'login_page.dart';
import 'model/login.dart';
import 'mortgage_intro.dart';
import 'package:flutter/services.dart';
import 'package:simple_permissions/simple_permissions.dart';

import 'signup_page.dart';

class _IntroScreenPageState extends State<IntroScreenMainPage> {
  final _controller = new PageController();

  static const platform = const MethodChannel('hopelabs.fintechapp/email');
  List<dynamic> emailList = <dynamic>[];

  Future<void> _getEmails() async {
    final result =
        await SimplePermissions.checkPermission(Permission.ReadContacts);
    if (!result) {
      var status =
          await SimplePermissions.requestPermission(Permission.ReadContacts);
      if (status != PermissionStatus.authorized) {
        print('Not Authorized');
      }
    }

    try {
      var list = await platform.invokeMethod('getEmailList');
      if (list != null && mounted) {
        setState(() {
          emailList = list;
        });
      }
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  final List<Widget> _pages = [
    BudgetIntroScreen(),
    MortgageIntroScreen(),
  ];
  int page = 0;

  @override
  void initState() {
    super.initState();
    _getEmails();
  }

  @override
  Widget build(BuildContext context) {
    bool isDone = page == _pages.length - 1;
    return new Scaffold(
        backgroundColor: Colors.transparent,
        body: new Stack(
          children: <Widget>[
            new Positioned.fill(
              child: new PageView.builder(
                physics: new AlwaysScrollableScrollPhysics(),
                controller: _controller,
                itemCount: _pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _pages[index % _pages.length];
                },
                onPageChanged: (int p) {
                  setState(() {
                    page = p;
                  });
                },
              ),
            ),
            new Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: new SafeArea(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  primary: false,
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        isDone ? 'DONE' : 'NEXT',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: isDone
                          ? () {
                              Navigator.pop(context);
                            }
                          : () {
                              _controller.animateToPage(page + 1,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                    )
                  ],
                ),
              ),
            ),
            new Positioned(
              bottom: 10.0,
              left: 0.0,
              right: 0.0,
              child: new SafeArea(
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new DotsIndicator(
                        controller: _controller,
                        itemCount: _pages.length,
                        onPageSelected: (int page) {
                          _controller.animateToPage(
                            page,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Container(
                          width: 150.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                colors: [
                                  Colors.deepPurple[600],
                                  Colors.deepPurple[900],
                                ],
                                begin: Alignment(0.5, -1.0),
                                end: Alignment(0.5, 1.0)),
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: new Material(
                            child: MaterialButton(
                              child: Text(
                                'SIGNUP',
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: Colors.white),
                              ),
                              onPressed: (){
                                Navigator.of(context).pushNamed(SignUpPage.tag);
                              },
                              highlightColor: Colors.blue.withOpacity(0.5),
                              splashColor: Colors.blue.withOpacity(0.5),
                            ),
                            color: Colors.transparent,
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        new Container(
                          width: 150.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(30.0),
                            border: Border.all(color: Colors.white, width: 1.0),
                            color: Colors.transparent,
                          ),
                          child: new Material(
                            child: MaterialButton(
                              child: Text(
                                'LOG IN',
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: Colors.white),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => new AlertDialog(
                                          content: Container(
                                            height: 200.0,
                                            child: ListView.builder(
                                              padding: new EdgeInsets.all(10.0),
                                              itemCount: emailList.length,
                                              itemBuilder: (context, int) {
                                                return ListTile(
                                                  leading: const Icon(Icons.email),
                                                  title: Text(emailList[int]),
                                                  onTap: () {
                                                    Navigator.of(context, rootNavigator: true).pop();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => LoginPage(login: Login(emailList[int], "password") ))
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ));
                              },
                              highlightColor: Colors.white30,
                              splashColor: Colors.white30,
                            ),
                            color: Colors.transparent,
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class IntroScreenMainPage extends StatefulWidget {
  static String tag = 'intro-page';
  IntroScreenMainPage({Key key}) : super(key: key);

  @override
  _IntroScreenPageState createState() => new _IntroScreenPageState();
}
