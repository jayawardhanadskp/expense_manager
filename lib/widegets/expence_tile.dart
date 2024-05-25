import 'package:expence_manager/model/expence.dart';
import 'package:flutter/material.dart';

class ExpenceTile extends StatelessWidget {

  final ExpenceModel expence;
  const ExpenceTile({super.key, required this.expence});

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expence.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8,),

            Row(
              children: [
                Text(
                  expence.amount.toStringAsFixed(2),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(CategoryIcons[expence.category]),
                    const SizedBox(width: 10,),
                    Text(expence.getFormatedDate)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
