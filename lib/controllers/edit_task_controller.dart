import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repositories/task_repository.dart';
import '../utils/helper.dart';

final class EditTaskController extends GetxController {
  RxBool isLoading = false.obs;
  final titleC = TextEditingController();
  final descriptionC = TextEditingController();
  final repo = TaskRepository();

  void editTask(BuildContext context,
      {int? salesId,
      String? status,
      String? salesName,
      DateTime? scheduleAt,
      required int taskId}) async {
    try {
      isLoading.value = true;
      final result = await repo.editTask(
          params: TaskParams(
              taskId: taskId,
              title: titleC.text,
              description: descriptionC.text,
              status: status,
              scheduleAt: scheduleAt,
              salesName: salesName,
              salesId: salesId));
      result.when(error: (e) async {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        context.pop();
        showCustomSnackbar(s.message);
      });
    } finally {
      isLoading.value = false;
    }
  }
}
