import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoLvlup/Theme/app_colors.dart';
import 'package:todoLvlup/domain/entity/task_model.dart';
import 'package:todoLvlup/presenation/create.dart';
import 'package:todoLvlup/presenation/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lvl up',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mainDarkBlue,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.mainDarkBlue,
          selectedItemColor: AppColors.bottomNavigationSelectedItemColor,
          unselectedItemColor: AppColors.bottomNavigationUnselectedItemColor,
        ),
      ),
      routes: {
        '/': (context) => const HomeWidget(),
        '/create': (context) => const Create(),
      },
      initialRoute: '/',
    );
  }
}
