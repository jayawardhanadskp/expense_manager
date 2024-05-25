import 'package:expence_manager/server/database.dart';
import 'package:expence_manager/widegets/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pie_chart/pie_chart.dart';


import '../model/expence.dart';
import '../widegets/add_new_expense.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  
  final _myBox = Hive.box('expenseDatabase');
  Database db = Database();
  
  // expences list
/*  final List<ExpenceModel> _expensesList = [
    ExpenceModel(
      amount: 12.5,
      date: DateTime.now(),
      title: 'Carrot',
      category: Category.food,
    ),
    ExpenceModel(
      amount: 10,
      date: DateTime.now(),
      title: 'Football',
      category: Category.leasure,
    ),
    ExpenceModel(
      amount: 10,
      date: DateTime.now(),
      title: 'Football',
      category: Category.leasure,
    ),
  ];  */

  Map<String, double> dataMap = {
    'Food': 0,
    'Travel' : 0,
    'Leisure': 0,
    'Work': 0,
  };


  // funtion to open a model overlay
  void _openAddExpencesOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddNewExpenses(
            onAddExpence: onAddNewExpence,);
        });
  }

  // add new expence
  void onAddNewExpence (ExpenceModel expence) {
    setState(() {
      db.expenceList.add(expence);
      calCategoryValues();
    });
    db.updateData();
  }

  // remove an expense
  void onDeleteExpence(ExpenceModel expence) {
    // store the deleted expense
    ExpenceModel deletingExpence = expence;

    // get the remove index
    final int removingIndex = db.expenceList.indexOf(expence);

    setState(() {
      db.expenceList.remove(expence);
      db.updateData();
      calCategoryValues();
    });

    // show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Delete Successful'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              db.expenceList.insert(removingIndex, deletingExpence);
              db.updateData();
              calCategoryValues();
            });
          },
        ),
      ),
    );
  }

  // PIE CHART
  double foodVal = 0;
  double travelVal = 0;
  double leisureVal = 0;
  double workVal = 0;

  void calCategoryValues() {
    double foodValTotal = 0;
    double travelValTotal = 0;
    double leisureValTotal = 0;
    double workValTotal = 0;

    for (final expence in db.expenceList) {
      if (expence.category == Category.food) {
        foodValTotal += expence.amount;
      }
      if (expence.category == Category.travel) {
        travelValTotal += expence.amount;
      }
      if (expence.category == Category.leasure) {
        leisureValTotal += expence.amount;
      }
      if (expence.category == Category.work) {
        workValTotal += expence.amount;
      }
    }

    setState(() {
      foodVal = foodValTotal;
      travelVal = travelValTotal;
      leisureVal = leisureValTotal;
      workVal = workValTotal;
    });

    // update data map
    dataMap = {
      'Food': foodVal,
      'Travel' : travelVal,
      'Leisure': leisureVal,
      'Work': workVal,
    };
  }

  @override
  void initState() {
    super.initState();

    // this is the first time create the initial data
    if (_myBox.get('EXP_DATA') == null) {
      db.createInialDatabase();
      calCategoryValues();
    }  else {
      db.loadData();
      calCategoryValues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Expense Mater',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple.shade700,
        actions: [
          Container(
            color: Colors.white70,
            child: IconButton(
                onPressed:
                  _openAddExpencesOverlay,

                icon: const Icon(Icons.add, color: Colors.black,)),
          )
        ],
      ),

      body: Column(
        children: [
          PieChart(dataMap: dataMap),
          ExpensesList(expancesList: db.expenceList, onDeleteExpence: onDeleteExpence,),
        ],
      ),
    );
  }
}
