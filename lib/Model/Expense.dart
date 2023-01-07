import 'package:sqflite/sqflite.dart';

final String table = 'Expense';

class Expense {
  int id;
  final String title;
  final String amount;
  final String type;
  final String date;
  Expense(
    this.id, {
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });

  Map<String, Object> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type,
      'date': date
    };
  }

  String toString() {
    return 'Expense{id: $id, title: $title, amount: $amount, type: $type}, date: $date}}';
  }
}
