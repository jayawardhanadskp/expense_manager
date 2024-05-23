import 'package:expence_manager/widegets/expenses_list.dart';
import 'package:flutter/material.dart';

import '../model/expence.dart';

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
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          )
        ],
      ),

      body: Column(
        children: [
          ExpensesList(expancesList: _expensesList,),
        ],
      ),
    );
  }
}
