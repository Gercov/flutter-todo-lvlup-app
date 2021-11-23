import 'package:lvlup/domain/services/hive_service.dart';

class TaskListDataProvider {
  final _hiveService = HiveService.instance;
  static const tasksBoxName = 'tasks';
  static const completedTasksBoxName = 'completedTasks';

  Future<List> loadTasks() async {
    return await _hiveService.getData(tasksBoxName);
  }

  Future<List> loadCompletedTasks() async {
    return await _hiveService.getData(completedTasksBoxName);
  }

  Future<void> saveTask(List tasks) async {
    await _hiveService.saveData(tasksBoxName, tasks);
  }

  Future<void> savCompletedeTask(List tasks) async {
    await _hiveService.saveData(completedTasksBoxName, tasks);
  }
}
