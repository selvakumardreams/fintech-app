import 'package:diafcon/main.dart';
import 'package:diafcon/models/category.dart';
import 'package:diafcon/pages/add_expense.dart';
import 'package:diafcon/pages/settings.dart';
import 'package:diafcon/scoped_models/app_model.dart';
import 'package:diafcon/widgets/expenses/expenses_builder.dart';
import 'package:diafcon/widgets/navigation/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

List<Category> categories;

class BudgetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BudgetPageState();
  }
}

class _BudgetPageState extends State<BudgetPage> {
  int _selectedIndex = 0;

  final _widgetOptions = [
    ExpensesList(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  _buildDrawer() {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget widget, AppModel model) {
        categories = model.allCategories;
        return SideDrawer(model.updateCategoryFilter, model.updateSort,
            model.sortBy, model.allCategories, model.startDate, model.endDate);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deviceTheme == "light"
          ? Colors.grey[100]
          : Theme.of(context).primaryColorLight,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddExpense(),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 5.0,
        icon: const Icon(Icons.add),
        label: const Text('Add Expense'),
      )
          : Container(
        width: 0,
        height: 0,
      ),
      drawer: _buildDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        color: deviceTheme == "light" ? Colors.white : Colors.grey[900],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  MdiIcons.cashRegister,
                  size: 30,
                  color: _selectedIndex == 0
                      ? Theme.of(context).accentColor
                      : Colors.grey[500],
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  MdiIcons.settings,
                  size: 30,
                  color: _selectedIndex == 1
                      ? Theme.of(context).accentColor
                      : Colors.grey[500],
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
