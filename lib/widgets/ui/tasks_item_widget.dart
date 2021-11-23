import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lvlup/Theme/app_colors.dart';
import 'package:lvlup/widgets/completed_tasks_list_screen.dart';
import 'package:lvlup/widgets/tasks_list_screen.dart';

class TaskItemWidget extends StatelessWidget {
  final String taskText;
  final int scoreTask;
  final int index;
  final bool completed;

  const TaskItemWidget({
    Key? key,
    required this.taskText,
    required this.scoreTask,
    required this.index,
    required this.completed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.mainDarkBlue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: Text(
                taskText,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 30),
            _TaskButtonWidget(completed: completed, index: index)
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const Icon(
              Icons.monetization_on_outlined,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text('$scoreTask'),
          ],
        ),
      ]),
    );
  }
}

class _TaskButtonWidget extends StatelessWidget {
  final int index;
  final bool completed;

  const _TaskButtonWidget({
    Key? key,
    required this.index,
    required this.completed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Function buttonFunction;

    try {
      buttonFunction = completed
          ? context.read<CompletedTasksListViewModel>().onPressedTaskItemButton
          : context.read<TasksListViewModel>().onPressedTaskItemButton;
    } catch (e) {
      buttonFunction = () {};
    }

    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: () => buttonFunction(index),
      splashRadius: 20,
      icon: Icon(
        completed ? Icons.delete : Icons.check,
        color: completed ? Colors.red : AppColors.mainDarkBlue,
      ),
    );
  }
}
