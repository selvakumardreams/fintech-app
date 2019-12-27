import 'package:diafcon/widgets/intro/circles_with_image.dart';
import 'package:flutter/material.dart';


const double IMAGE_SIZE = 200.0;

class BudgetIntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: double.infinity,
      width: double.infinity,
      decoration: new BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blue[300],
        Colors.blue[500],
        Colors.blue[800],
      ], begin: Alignment(0.5, -1.0), end: Alignment(0.5, 1.0))),
      child: Stack(
        children: <Widget>[
          new Positioned(
            child: new CircleWithImage("assets/budget.png"),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          new Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: Image(
                    image: AssetImage("assets/budget.png"),
                    fit: BoxFit.fitHeight,
                  ),
                  height: IMAGE_SIZE,
                  width: IMAGE_SIZE,
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Budget',
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  'Budget from Diafcon',
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        ],
        alignment: FractionalOffset.center,
      ),
    );
  }
}
