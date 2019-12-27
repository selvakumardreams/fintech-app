import 'package:diafcon/models/expense.dart';
import 'package:diafcon/pages/expense_overview.dart';
import 'package:diafcon/scoped_models/app_model.dart';
import 'package:diafcon/widgets/expenses/expense_tile.dart';
import 'package:firebase_database/firebase_database.dart';

import 'dart:core';
import 'dart:async';

import 'package:diafcon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:diafcon/main.dart';

class ExpenseList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpenseListState();
  }
}

class _ExpenseListState extends State<ExpenseList> {
  TextEditingController controller = TextEditingController();

  Future<void> _getData(User user, Function setExpenses, DateTime lastUpdate,
      BuildContext context, Function gotNoData) async {
    if (lastUpdate == null) {
      DataSnapshot snapshot = await FirebaseDatabase.instance
          .reference()
          .child('users/${user.uid}/expenses')
          .once();

      List<Expense> expenses = [];
      Map<dynamic, dynamic> expenseMap = snapshot.value;
      if (expenseMap == null) {
        return gotNoData();
      }
      expenseMap.forEach((key, value) {
        expenses.add(Expense.fromJson(key, value));
      });
      setExpenses(expenses);
      return ('');
    }
    Duration difference = DateTime.now().difference(lastUpdate);
    if (difference.inMinutes < 10) {
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor:
            deviceTheme == "light" ? Colors.blueAccent : Colors.blue[800],
        content: Text(
            "Next update available in ${10 - difference.inMinutes} minutes."),
        action: SnackBarAction(
          onPressed: () {
            Scaffold.of(context).hideCurrentSnackBar();
          },
          label: "Dismiss",
          textColor: Colors.white,
        ),
      ));
    } else {
      DataSnapshot snapshot = await FirebaseDatabase.instance
          .reference()
          .child('users/${user.uid}/expenses')
          .once();

      List<Expense> expenses = [];
      Map<dynamic, dynamic> expenseMap = snapshot.value;
      if (expenseMap == null) {
        return gotNoData();
      }
      expenseMap.forEach((key, value) {
        expenses.add(Expense.fromJson(key, value));
      });
      setExpenses(expenses);
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor:
            deviceTheme == "light" ? Colors.blueAccent : Colors.blue[800],
        content: Text("Next update available in 10 minutes."),
        action: SnackBarAction(
          onPressed: () {
            Scaffold.of(context).hideCurrentSnackBar();
          },
          label: "Dismiss",
          textColor: Colors.white,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget widget, AppModel model) {
        List<Expense> expenses = model.filteredExpenses;
        double total = 0;
        expenses.forEach((expense) {
          double price = double.parse(expense.amount) / 100;
          total = total + price;
        });
        return GestureDetector(
          onTap: () {
            if (controller.text == null) {
              FocusScope.of(context).requestFocus(new FocusNode());
            }
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: deviceTheme == "light"
                    ? Theme.of(context).accentColor
                    : Colors.grey[900],
                automaticallyImplyLeading: false,
                pinned: false,
                floating: false,
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: SafeArea(
                      bottom: false,
                      top: true,
                      child: Column(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.none,
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: TextField(
                              controller: controller,
                              onChanged: (String value) {
                                print(value);
                                model.updateSearchQuery(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                  vertical: 15.0,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                hintText: "Search",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                filled: true,
                                fillColor: deviceTheme == "light"
                                    ? Colors.white
                                    : Colors.grey[600],
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.menu),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      controller.text = "";
                                    });
                                    model.updateSearchQuery("");
                                  },
                                ),
                              ),
                            ),
                          ),
                          Wrap(
                            children: <Widget>[
                              Text(
                                expenses.length.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "expenses totalling",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "${model.userCurrency}${model.userCurrency == "€" ? total.toStringAsFixed(2).replaceAll(".", ",") : total.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Currently sorting by ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "${model.sortBy}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  if (model.allExpenses.length > 0) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ExpenseOverview(),
                                      ),
                                    );
                                  } else {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: deviceTheme == "light"
                                            ? Colors.blueAccent
                                            : Colors.blue[800],
                                        content: Text("No expenses found."),
                                        action: SnackBarAction(
                                          onPressed: () {
                                            Scaffold.of(context)
                                                .hideCurrentSnackBar();
                                          },
                                          label: "Dismiss",
                                          textColor: Colors.white,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.pie_chart,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      "Overview",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                onPressed: () => _getData(
                                    model.authenticatedUser,
                                    model.setExpenses,
                                    model.lastUpdate,
                                    context,
                                    model.gotNoData),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      "Refresh",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ExpenseTile(
                        expenses[index],
                        index,
                        model.expenseCategory,
                        model.userCurrency,
                        model.deleteExpense);
                  },
                  childCount: expenses.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
