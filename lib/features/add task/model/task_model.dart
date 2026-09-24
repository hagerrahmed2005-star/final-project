import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String date;

  @HiveField(3)
  int color;

  @HiveField(4)
  String status;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    required this.color,
    this.status = "pending",
  });
}