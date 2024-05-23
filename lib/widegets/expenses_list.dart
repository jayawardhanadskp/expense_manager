import 'package:flutter/material.dart';

import '../model/expence.dart';
import 'expence_tile.dart';

class ExpensesList extends StatelessWidget {
  final List<ExpenceModel> expancesList;
  const ExpensesList({super.key, required this.expancesList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expancesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: ExpenceTile(
                  expence: expancesList[index],
              ),
            );
          }),
    );
  }
}
