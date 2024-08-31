import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repositories/task_repository.dart';
import '../utils/helper.dart';

final class AddTaskController extends GetxController {
  RxBool isLoading = false.obs;
  final titleC = TextEditingController();
  final descriptionC = TextEditingController();
  final repo = TaskRepository();

  void addTask(BuildContext context,
      {required int salesId, required DateTime scheduleAt}) async {
    try {
      isLoading.value = true;
      final result = await repo.addTask(
          params: TaskParams(
              title: titleC.text,
              description: descriptionC.text,
              scheduleAt: scheduleAt,
              salesId: salesId));
      result.when(error: (e) async {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        context.pop();
        titleC.clear();
        descriptionC.clear();
        showCustomSnackbar(s.message);
      });
    } finally {
      isLoading.value = false;
    }
  }
}
