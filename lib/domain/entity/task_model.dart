import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final int score;

  @HiveField(2)
  final int id;

  @HiveField(3)
  final bool completed;

  TaskModel({
    this.completed = false,
    required this.text,
    required this.score,
    required this.id,
  });

  TaskModel copyWith({
    String? text,
    int? score,
    int? id,
    bool? completed,
  }) {
    return TaskModel(
      text: text ?? this.text,
      score: score ?? this.score,
      id: id ?? this.id,
      completed: completed ?? this.completed,
    );
  }
}
