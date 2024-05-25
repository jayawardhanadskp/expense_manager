import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'expence.g.dart';


// create unique id
final uuid = const Uuid().v4();

// date formatter
final formatDate = DateFormat.yMd();

// categiry icons
final CategoryIcons = {
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.leak_add,
  Category.leasure : Icons.travel_explore,
  Category.work : Icons.work,
};

// enum for catogary
enum Category {food, travel, leasure, work}

@HiveType(typeId: 1)
class ExpenceModel {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final Category category;

  // constructors
  ExpenceModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid;

  // getter for format date
  String get getFormatedDate {
    return formatDate.format(date);
  }
}
