import 'package:flutter/material.dart';
import 'package:lvlup/domain/entity/home_tab.dart';
import 'package:lvlup/widgets/completed_tasks_list_screen.dart';
import 'package:lvlup/widgets/tasks_list_screen.dart';

abstract class HomeTabsList {
  static final options = [
    HomeTab(
      name: 'Задания',
      icon: const Icon(Icons.list),
    ),
    HomeTab(
      name: 'Выполенные',
      icon: const Icon(Icons.check),
    ),
    HomeTab(
      name: 'Настройки',
      icon: const Icon(Icons.settings),
    ),
  ];

  static const screens = [
    TasksListScreen(),
    CompletedTasksListScreen(),
    Center(child: Text('Настройки')),
  ];
}
