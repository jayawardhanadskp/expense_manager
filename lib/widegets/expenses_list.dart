import 'package:flutter/material.dart';

import '../model/expence.dart';
import 'expence_tile.dart';

class ExpensesList extends StatelessWidget {
  final List<ExpenceModel> expancesList;
  final void Function (ExpenceModel expence) onDeleteExpence;
  const ExpensesList({super.key, required this.expancesList, required this.onDeleteExpence});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expancesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Dismissible(
                key: ValueKey(expancesList[index]),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  onDeleteExpence(expancesList[index]);
                },
                child: ExpenceTile(
                    expence: expancesList[index],
                ),
              ),
            );
          }),
    );
  }
}
