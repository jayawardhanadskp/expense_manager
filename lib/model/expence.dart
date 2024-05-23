import 'package:uuid/uuid.dart';

// create unique id
final uuid = const Uuid().v4();

// enum for catogary
enum Category {food, travel, leasure, work}

class ExpenceModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // constructors
  ExpenceModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid;
}
