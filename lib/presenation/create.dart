import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lvlup/domain/services/tasks_list_service.dart';

class CreateViewModelState {
  final String taskText;
  final String taskScore;

  CreateViewModelState({
    required this.taskText,
    required this.taskScore,
  });

  CreateViewModelState copyWith({
    String? taskText,
    String? taskScore,
  }) {
    return CreateViewModelState(
      taskText: taskText ?? this.taskText,
      taskScore: taskScore ?? this.taskScore,
    );
  }
}

class CreateViewModel extends ChangeNotifier {
  final _taskListService = TasksListService.instance;
  var _state = CreateViewModelState(taskText: '', taskScore: '');

  void onInputTaskTextField(String value) {
    _state = _state.copyWith(taskText: value);
  }

  void onInputTaskScoreField(String value) {
    _state = _state.copyWith(taskScore: value);
  }

  void onPressedCreateButton(BuildContext context) {
    bool status =
        _taskListService.createTask(_state.taskText, _state.taskScore);
    if (status) {
      Navigator.of(context).pop();
    }
  }
}

class Create extends StatelessWidget {
  const Create({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TasksListService.instance.createTask();
    return ChangeNotifierProvider(
      create: (context) => CreateViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Создание задания'),
        ),
        body: const _CreateInputsWidget(),
        floatingActionButton: const _CreateCreateButton(),
      ),
    );
  }
}

class _CreateInputsWidget extends StatelessWidget {
  const _CreateInputsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final saveTextTask = context.watch<CreateViewModel>().onInputTaskTextField;
    final saveScoreTask =
        context.watch<CreateViewModel>().onInputTaskScoreField;

    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          _TaskTextField(saveTextTask: saveTextTask),
          const SizedBox(
            height: 15,
          ),
          _TaskScoreWidget(saveScoreTask: saveScoreTask),
        ],
      ),
    );
  }
}

class _TaskTextField extends StatelessWidget {
  const _TaskTextField({
    Key? key,
    required this.saveTextTask,
  }) : super(key: key);

  final void Function(String value) saveTextTask;

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: (String value) => saveTextTask(value),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Введите текст задания',
          prefixIcon: Icon(Icons.text_fields),
        ));
  }
}

class _TaskScoreWidget extends StatelessWidget {
  const _TaskScoreWidget({
    Key? key,
    required this.saveScoreTask,
  }) : super(key: key);

  final void Function(String value) saveScoreTask;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (String value) => saveScoreTask(value),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Введите кол-во поинтов',
        prefixIcon: Icon(Icons.monetization_on_outlined),
        helperText: 'Не более 100',
      ),
    );
  }
}

class _CreateCreateButton extends StatelessWidget {
  const _CreateCreateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final createTask = context.watch<CreateViewModel>().onPressedCreateButton;

    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        child: const Text('Создать'),
        onPressed: () => createTask(context),
      ),
    );
  }
}
