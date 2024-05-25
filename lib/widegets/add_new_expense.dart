import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/expence.dart' as expence_model;
import '../model/expence.dart';

class AddNewExpenses extends StatefulWidget {

  final void Function(ExpenceModel expence) onAddExpence;
  AddNewExpenses({super.key, required this.onAddExpence});

  @override
  State<AddNewExpenses> createState() => _AddNewExpensesState();
}

class _AddNewExpensesState extends State<AddNewExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  expence_model.Category _selectedCategory = expence_model.Category.leasure;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  // Form validation
  void _handleFormSubmit() {
    final userAmount = double.tryParse(_amountController.text.trim());

    if (_titleController.text.trim().isEmpty || userAmount == null || userAmount <= 0) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Enter valid Data'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'))
              ],
            );
          });
    } else {

      // create new expence
      ExpenceModel newExpence = ExpenceModel(
        amount: userAmount,
        date: _selectedDate,
        title: _titleController.text.trim(),
        category: _selectedCategory
      );

      widget.onAddExpence(newExpence);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Add new Title',
              labelText: 'Title',
            ),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Amount
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    hintText: 'Enter the amount',
                    labelText: 'Amount',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Date picker
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${_selectedDate.toLocal()}'.split(' ')[0],
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.date_range_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Category Dropdown and Buttons
          Row(
            children: [
              DropdownButton<expence_model.Category>(
                value: _selectedCategory,
                items: expence_model.Category.values
                    .map(
                      (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.name),
                  ),
                )
                    .toList(),
                onChanged: (expence_model.Category? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Close'),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: _handleFormSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
