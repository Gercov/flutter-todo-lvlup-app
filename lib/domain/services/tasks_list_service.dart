import 'dart:async';
import 'package:lvlup/domain/data_providers/task_list_provider.dart';
import 'package:lvlup/domain/entity/task_model.dart';

class TasksListService {
  List _tasks = [];
  List _completedTasks = [];
  final _taskListDataProvider = TaskListDataProvider();
  final StreamController _streamTasksController =
      StreamController<void>.broadcast();

  final StreamController _streamCompletedTasksController =
      StreamController<void>.broadcast();

  static final instance = TasksListService._();

  Stream get tasksUpdates => _streamTasksController.stream;
  Stream get completedTasksUpdates => _streamCompletedTasksController.stream;
  List get tasks => _tasks;
  List get completedTasks => _completedTasks;

  TasksListService._();

  Future<void> loadTasks() async {
    _tasks = await _taskListDataProvider.loadTasks();
  }

  Future<void> loadCompletedTasks() async {
    _completedTasks = await _taskListDataProvider.loadCompletedTasks();
  }

  TaskModel createTaskModel(String text, int score) {
    final int id = DateTime.now().microsecondsSinceEpoch;
    return TaskModel(text: text, score: score, id: id);
  }

  bool createTask(String text, String score) {
    try {
      if (text.isEmpty || score.isEmpty) return false;

      int parsedScore = int.parse(score);

      final newTaskModel = createTaskModel(text, parsedScore);
      _tasks = [newTaskModel, ..._tasks];
      _taskListDataProvider.saveTask(_tasks);
      _streamTasksController.add(_tasks);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> movieTaskToCompletedList(int index) async {
    final completedTask = _tasks.removeAt(index);
    final updateStatus = TaskModel(
      text: completedTask.text,
      score: completedTask.score,
      id: completedTask.id,
      completed: true,
    );
    _completedTasks.insert(0, updateStatus);
    await _taskListDataProvider.savCompletedeTask(_completedTasks);
    await _taskListDataProvider.saveTask(_tasks);
    _streamCompletedTasksController.add(_completedTasks);
  }

  Future<void> deleteCompletedTask(int index) async {
    _completedTasks.removeAt(index);
    await _taskListDataProvider.savCompletedeTask(_completedTasks);
  }
}
