import 'package:flutter/material.dart';
import 'package:lvlup/widgets/items_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:lvlup/domain/services/tasks_list_service.dart';

class CompletedTasksListViewModelState {
  List tasks;
  CompletedTasksListViewModelState({
    required this.tasks,
  });
}

class CompletedTasksListViewModel extends ChangeNotifier {
  final _taskListService = TasksListService.instance;
  var _state = CompletedTasksListViewModelState(tasks: []);

  CompletedTasksListViewModelState get state => _state;

  CompletedTasksListViewModel() {
    _taskListService.completedTasksUpdates
        .listen((tasks) => updateState(tasks));
    initialize();
  }

  void initialize() async {
    await _taskListService.loadCompletedTasks();
    _state = CompletedTasksListViewModelState(
        tasks: _taskListService.completedTasks);
    notifyListeners();
  }

  void updateState(List newTasks) {
    _state = CompletedTasksListViewModelState(tasks: newTasks);
    notifyListeners();
  }

  void onPressedTaskItemButton(int index) async {
    await _taskListService.deleteCompletedTask(index);
    _state = CompletedTasksListViewModelState(
        tasks: _taskListService.completedTasks);
    notifyListeners();
  }
}

class CompletedTasksListScreen extends StatelessWidget {
  const CompletedTasksListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: CompletedTasksListViewModel(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksList = context.watch<CompletedTasksListViewModel>().state.tasks;

    return ItemsListWidget(
      tasksList: tasksList,
    );
  }
}
