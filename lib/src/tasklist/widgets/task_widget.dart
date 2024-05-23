import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/task.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => ,
      child: Container(
      width: Get.width,
      height: Get.width / 2.0 / 1.618,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${this.task.title}',
            style: textTheme.headlineMedium!.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w400,
            ),
          ), // Text
        ],
      ), // Column
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ), // BorderRadius
        color: colorScheme.primary,
      ), // BoxDecoration
    ), //Container
    ); // GestureDetector
  }
}
