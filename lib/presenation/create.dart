import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:todoLvlup/Theme/app_colors.dart';

import 'package:todoLvlup/domain/services/tasks_list_service.dart';

class CreateViewModelState {
  final String taskText;
  final int taskScore;

  CreateViewModelState({
    this.taskText = '',
    this.taskScore = 10,
  });

  CreateViewModelState copyWith({
    String? taskText,
    int? taskScore,
  }) {
    return CreateViewModelState(
      taskText: taskText ?? this.taskText,
      taskScore: taskScore ?? this.taskScore,
    );
  }
}

class CreateViewModel extends ChangeNotifier {
  final _taskListService = TasksListService.instance;
  var _state = CreateViewModelState();

  CreateViewModelState get state => _state;

  void onInputTaskTextField(String value) {
    _state = _state.copyWith(taskText: value);
  }

  void onInputTaskScoreField(int value) {
    _state = _state.copyWith(taskScore: value);
    notifyListeners();
  }

  void onPressedButtonIncrementScore() {
    _state = _state.copyWith(taskScore: min(_state.taskScore + 10, 100));
    notifyListeners();
  }

  void onPressedButtonDecrementScore() {
    _state = _state.copyWith(taskScore: max(_state.taskScore - 10, 10));
    notifyListeners();
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
        body: const _View(),
        floatingActionButton: const _CreateCreateButton(),
      ),
    );
  }
}

class _View extends StatelessWidget {
  const _View({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: const [
          _TaskTextField(),
          SizedBox(
            height: 15,
          ),
          _TaskScoreWidget(),
        ],
      ),
    );
  }
}

class _TaskTextField extends StatelessWidget {
  const _TaskTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<CreateViewModel>();
    return TextField(
        onChanged: (String value) => model.onInputTaskTextField(value),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<CreateViewModel>();
    final currentScores =
        context.select((CreateViewModel model) => model.state.taskScore);

    final BoxDecoration buttonsDecoration = BoxDecoration(
      border: Border.all(color: AppColors.mainDarkBlue),
      borderRadius: BorderRadius.circular(10),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DecoratedBox(
          decoration: buttonsDecoration,
          child: IconButton(
            splashRadius: 30,
            onPressed: model.onPressedButtonDecrementScore,
            icon: const Icon(Icons.remove),
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(10),
          ),
        ),
        NumberPicker(
          minValue: 10,
          maxValue: 100,
          value: currentScores,
          step: 10,
          onChanged: (int value) => model.onInputTaskScoreField(value),
          axis: Axis.horizontal,
          itemWidth: 50,
          itemCount: 5,
          textStyle: const TextStyle(color: AppColors.mainDarkBlue),
        ),
        DecoratedBox(
          decoration: buttonsDecoration,
          child: IconButton(
            splashRadius: 30,
            onPressed: model.onPressedButtonIncrementScore,
            icon: const Icon(Icons.add),
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(10),
          ),
        ),
      ],
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
