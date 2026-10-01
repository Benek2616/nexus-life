import 'package:isar/isar.dart';

part 'models.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;

  late String title;
  late double amount;
  late DateTime date;
  String? category;
  String? note;
  String? receiptPath; // lokalna ścieżka do zdjęcia paragonu
  late DateTime createdAt;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    this.category,
    this.note,
    this.receiptPath,
  }) : createdAt = DateTime.now();
}

@collection
class Habit {
  Id id = Isar.autoIncrement;

  late String name;
  String? description;
  late int targetPerDay; // np. 1
  late List<DateTime> completedDates;
  late DateTime createdAt;
  bool isArchived = false;

  Habit({
    required this.name,
    this.description,
    this.targetPerDay = 1,
  })  : completedDates = [],
        createdAt = DateTime.now();
}

@collection
class Note {
  Id id = Isar.autoIncrement;

  late String content;
  String? title;
  List<String> tags = [];
  late DateTime createdAt;
  late DateTime updatedAt;

  Note({
    required this.content,
    this.title,
    this.tags = const [],
  })  : createdAt = DateTime.now(),
        updatedAt = DateTime.now();
}

@collection
class Event {
  Id id = Isar.autoIncrement;

  late String title;
  String? description;
  late DateTime start;
  DateTime? end;
  bool isAllDay = false;
  late DateTime createdAt;

  Event({
    required this.title,
    required this.start,
    this.description,
    this.end,
    this.isAllDay = false,
  }) : createdAt = DateTime.now();
}
