import 'dart:core';

import 'package:get/get.dart';
import 'package:nanoid2/nanoid2.dart';

import '../../debug/debug_controller.dart';
import '../../tasklist/task/task_item.dart';

class SeasonController extends GetxController {
  final id = nanoid();
  final started = DateTime.now();
  final DebugController debug = Get.find(tag: 'debugger');
  final task = Rxn<TaskItem>();

  @override
  void onInit() {
    super.onInit();
    debug.newInit(this.runtimeType.toString(), id, started);
    task.value = Get.arguments;
  }

  @override
  void onClose() {
    debug.newClose(this.runtimeType.toString(), id, DateTime.now());
    super.onClose();
  }
}
