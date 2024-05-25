import 'package:expence_manager/widegets/expenses_list.dart';
import 'package:flutter/material.dart';

import '../model/expence.dart';
import '../widegets/add_new_expense.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  // expences list
  final List<ExpenceModel> _expensesList = [
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
  ];

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
      _expensesList.add(expence);
    });
  }

  // remove an expense
  void onDeleteExpence(ExpenceModel expence) {
    // store the deleted expense
    ExpenceModel deletingExpence = expence;

    // get the remove index
    final int removingIndex = _expensesList.indexOf(expence);

    setState(() {
      _expensesList.remove(expence);
    });

    // show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Delete Successful'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expensesList.insert(removingIndex, deletingExpence);
            });
          },
        ),
      ),
    );
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
            color: Colors.white,
            child: IconButton(
                onPressed:
                  _openAddExpencesOverlay,

                icon: const Icon(Icons.add)),
          )
        ],
      ),

      body: Column(
        children: [
          ExpensesList(expancesList: _expensesList, onDeleteExpence: onDeleteExpence,),
        ],
      ),
    );
  }
}
