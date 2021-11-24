import 'package:flutter/material.dart';
import 'package:todoLvlup/domain/entity/home_tab.dart';
import 'package:todoLvlup/screens/completed_tasks_list_screen.dart';
import 'package:todoLvlup/screens/profile_screen.dart';
import 'package:todoLvlup/screens/tasks_list_screen.dart';

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
      name: 'Профиль',
      icon: const Icon(Icons.person),
    ),
    // HomeTab(
    //   name: 'Настройки',
    //   icon: const Icon(Icons.settings),
    // ),
  ];

  static const screens = [
    TasksListScreen(),
    CompletedTasksListScreen(),
    ProfileScreen(),
    // Center(child: Text('Настройки')),
  ];
}
