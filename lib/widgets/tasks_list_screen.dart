import 'package:flutter/material.dart';
import 'package:todoLvlup/widgets/items_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:todoLvlup/domain/services/tasks_list_service.dart';

class TasksListViewModelState {
  List tasks;
  TasksListViewModelState({
    required this.tasks,
  });
}

class TasksListViewModel extends ChangeNotifier {
  final _taskListService = TasksListService.instance;
  var _state = TasksListViewModelState(tasks: []);

  TasksListViewModelState get state => _state;

  TasksListViewModel() {
    _taskListService.tasksUpdates.listen((tasks) => updateState(tasks));
    initialize();
  }

  void initialize() async {
    await _taskListService.loadTasks();
    _state = TasksListViewModelState(tasks: _taskListService.tasks);
    notifyListeners();
  }

  void updateState(List newTasks) {
    _state = TasksListViewModelState(tasks: newTasks);
    notifyListeners();
  }

  Future<void> onPressedTaskItemButton(int index) async {
    await _taskListService.movieTaskToCompletedList(index);
    _state = TasksListViewModelState(tasks: _taskListService.tasks);
    notifyListeners();
  }
}

class TasksListScreen extends StatelessWidget {
  const TasksListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TasksListViewModel(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksList = context.watch<TasksListViewModel>().state.tasks;

    return tasksList.isNotEmpty
        ? ItemsListWidget(
            tasksList: tasksList,
          )
        : const _PlugTextWidget();
  }
}

class _PlugTextWidget extends StatelessWidget {
  const _PlugTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'У вас нет активных задач',
        style: TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }
}
