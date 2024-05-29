import 'dart:core';

import 'package:get/get.dart';

import '../debug/debug_controller.dart';
import '../routes/app_pages.dart';
import 'task/task_item.dart';

class TasklistController extends GetxController {
  final DebugController debug = Get.find(tag: 'debugger');
  final tasks = <TaskItem>[
TaskItem(
      id: 0,
      title: 'snooker ::: seasons',
      path: Routes.SNOOKERSEASONS,
    ),
    TaskItem(
      id: 1,
      title: 'snooker ::: events',
      path: Routes.SNOOKEREVENTS,
    ),
    TaskItem(
      id: 2,
      title: 'snooker ::: players',
      path: Routes.SNOOKERPLAYERS,
    ),
    TaskItem(
      id: 3,
      title: 'html ::: viewer',
      path: Routes.HTML,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    debug.newInit(this.runtimeType.toString());
    tasks.addAll(List<TaskItem>.generate(
        28,
        (int index) => TaskItem(
              id: index + 4,
              title: 'task ${index + 4}',
            )));
  }

  @override
  void onClose() {
    debug.newClose(this.runtimeType.toString());
    super.onClose();
  }
}
