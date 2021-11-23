import 'package:flutter/material.dart';

import 'package:todoLvlup/widgets/ui/tasks_item_widget.dart';

class ItemsListWidget extends StatelessWidget {
  final List tasksList;

  const ItemsListWidget({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasksList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: TaskItemWidget(
              taskText: tasksList[index].text,
              scoreTask: tasksList[index].score,
              index: index,
              completed: tasksList[index].completed,
            ),
          );
        });
  }
}
