import 'package:fintech_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

class TransactionPage extends StatefulWidget {
  static String tag = 'transaction-page';
  @override
  _TransactionPageState createState() => new _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
    @override
    Widget build(BuildContext context) {
      // ListTile.divideTiles adds divider between elements in a list
      // https://docs.flutter.io/flutter/material/ListTile/divideTiles.html
      var dividedWidgetList = ListTile.divideTiles(
          context: context,
          tiles: _getListData(),
          color: Colors.black).toList();

      return new Scaffold(
          backgroundColor: Color.fromRGBO(2, 30, 126, 1.0),
          appBar: new AppBar(
            backgroundColor: Color.fromRGBO(2, 30, 126, 1.0),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: new Text('Transaction Reports', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22.0)),
          ),
          body: new ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: List.generate(choices.length, (index) {
                return Center(
                  child: ChoiceCard(choice: choices[index], item: choices[index]
                )
                );
              }))
      );
    }

    _getListData() {
      List<Widget> widgets = [];
      print(_fetchPost());
      for (int i=0; i<10; i++) {
        widgets.add(
            new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Text('Expense                  $i'))
        );
      }
      return widgets;
    }

   _fetchPost() async {

      String url = 'https://api.openbankproject.com/my/logins/direct';
      Map<String, String> headers = {'Authorization': 'DirectLogin username="selvaopen",password="xxxx",consumer_key="dsg5i2pq1n4hdeqihmbo2tme1ozkedspbh11zzxr"'};
      Response response = await post(url, headers: headers);
      String token = json.decode(response.body)['token'];
      print(token);
      Map<String, String> headers_transactions = {'Authorization': 'DirectLogin token=' + token,
      'content-type': 'application/json'};
      print(headers_transactions);

      String transaction_url = url + '/obp/v3.1.0/banks/gh.29.uk/accounts/{3}/owner/transactions';
      Response response_transcation = await get(transaction_url, headers: headers_transactions);
    }
}

class Token {
  final String token;

  Token._({this.token});
  factory Token.fromJson(Map<String, dynamic> json) {
    return new Token._(
      token: json['token'],
    );
  }
}
class Choice {
  const Choice({this.title, this.icon, this.amount});

  final String title;
  final IconData icon;
  final String amount;
}

const List<Choice> choices = const <Choice>[
const Choice(title: 'Spotify', icon: Icons.apps, amount: '-\€10'),
const Choice(title: 'Uber', icon: Icons.directions_car, amount: '-\€12'),
const Choice(title: 'KLM', icon: Icons.flight, amount: '-\€120'),
const Choice(title: 'Mobile', icon: Icons.mobile_screen_share, amount: '-\€480'),
const Choice(title: 'Spotify', icon: Icons.apps, amount: '-\€10'),
const Choice(title: 'Uber', icon: Icons.directions_car, amount: '-\€12'),
const Choice(title: 'KLM', icon: Icons.flight, amount: '-\€120'),
const Choice(title: 'Mobile', icon: Icons.mobile_screen_share, amount: '-\€480'),
const Choice(title: 'Spotify', icon: Icons.apps, amount: '-\€10'),
const Choice(title: 'Uber', icon: Icons.directions_car, amount: '-\€12'),
const Choice(title: 'KLM', icon: Icons.flight, amount: '-\€120'),
const Choice(title: 'Mobile', icon: Icons.mobile_screen_share, amount: '-\€480'),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard(
      {Key key, this.choice, this.onTap, @required this.item, this.selected: false}
      ) : super(key: key);

  final Choice choice;
  final VoidCallback onTap;
  final Choice item;
  final bool selected;



  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            new Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.topLeft,
                child: Icon(choice.icon, size:30.0, color: textStyle.color,)),
            new Expanded(
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.topLeft,
                  child:
                  Text(choice.title, style: null, textAlign: TextAlign.left, maxLines: 5,),
                )
            ),
            new Expanded(
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.topRight,
                  child:
                  Text(choice.amount, style: null, textAlign: TextAlign.left, maxLines: 5,),
                )
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        )
    );
  }
}