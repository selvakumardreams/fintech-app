import 'package:flutter/material.dart';

String cardNumber;
String cardHolderName;
String month;
String year;
String cvv;

CardType cardtype;

enum CardType {
  diaxfcon,
  mastercard,
  visa,
  americanExpress,
  discover,
  dinnerClub
}

class CardWidget extends StatefulWidget {
  static String tag = 'card-page';

  @override
  _CardWidget createState() => _CardWidget();
}

class _CardWidget extends State<CardWidget> {
  @override
  void initState() {
    super.initState();
    cardNumber = cardNumber ?? "XXXX XXXX XXXX XXXX";
    cardHolderName = cardHolderName ?? "XXX";
    month = month ?? "XX";
    year = year ?? "XXXX";
    cvv = cvv ?? "XXX";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(2, 30, 126, 1.0),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Card',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22.0)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: cardDesign(context)),
          ],
        ),
      )),
    );
  }

  // ... Create a widget for Credit card UI ...
  Widget cardDesign(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      //padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(15.0),
      color: Colors.black54,
      child: Container(
          height: 190,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                //color: Colors.black,
                width: MediaQuery.of(context).size.width,
                // height: 200,
                child: Center(
                  //padding: EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    //color: Colors.grey,
                    child: Text(
                      'Diafcon',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 22.0),
                    ),
                  ),
                ),
              ),
              Container(
                // color: Colors.red,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'William Kintu',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  String cardNumberString() {
    if (cardNumber.length > 0) {
      return cardNumber;
    } else {
      return "XXXX XXXX XXX XXXX XXXX";
    }
  }

  String monthString() {
    if (month.length > 0) {
      return month;
    } else {
      return "XX";
    }
  }

  String yearString() {
    if (year.length > 0) {
      return year;
    } else {
      return "XXXX";
    }
  }

  // .... Get cardImage based on CardType ....
  Widget cardImage() {
    if (cardtype == CardType.visa) {
      return Image.asset(
        "images/visa.png",
        fit: BoxFit.scaleDown,
      );
    } else if (cardtype == CardType.diaxfcon) {
      return Image.asset(
        "images/mastercard.png",
        fit: BoxFit.scaleDown,
      );
    } else if (cardtype == CardType.discover) {
      return Image.asset(
        "images/discover.png",
        fit: BoxFit.scaleDown,
      );
    } else if (cardtype == CardType.dinnerClub) {
      return Image.asset(
        "images/diners_club.png",
        fit: BoxFit.scaleDown,
      );
    } else if (cardtype == CardType.americanExpress) {
      return Image.asset(
        "images/amex.png",
        fit: BoxFit.scaleDown,
      );
    }
    return null;
  }

  //... CardNumber pattern Array....

  Map<CardType, Set<List<String>>> cardNumberPattern = {
    CardType.visa: {
      ['4'],
    },
    CardType.americanExpress: {
      ['34'],
      ['37'],
    },
    CardType.discover: {
      ['6011'],
      ['622126', '622925'],
      ['644', '649'],
      ['65']
    },
    CardType.mastercard: {
      ['51', '55'],
      ['2221', '2229'],
      ['223', '229'],
      ['23', '26'],
      ['270', '271'],
      ['2720'],
    },
    CardType.dinnerClub: {
      ['54', '55'],
      ['300', '305'],
      ['3095'],
      ['36'],
      ['38', '39'],
    },
  };

// .... Detect card based on cardNumber.......
  CardType detectCardType(String cardNumber) {
    //Default card type is other
    CardType cardType = CardType.diaxfcon;

    if (cardNumber.isEmpty) {
      return cardType;
    }

    cardNumberPattern.forEach(
      (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          // Remove any spaces
          String ccPatternStr =
              cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;
          // Trim the Credit Card number string to match the pattern prefix length
          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1) {
            // Convert the prefix range into numbers then make sure the
            // Credit Card num is in the pattern range.
            // Because Strings don't have '>=' type operators
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt &&
                ccPrefixAsInt <= endPatternPrefixAsInt) {
              // Found a match
              cardType = type;
              break;
            }
          } else {
            // Just compare the single pattern prefix with the Credit Card prefix
            if (ccPatternStr == patternRange[0]) {
              // Found a match
              cardType = type;
              break;
            }
          }
        }
      },
    );

    return cardType;
  }
}
