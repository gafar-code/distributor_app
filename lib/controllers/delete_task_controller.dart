import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repositories/task_repository.dart';
import '../utils/helper.dart';

final class DeleteTaskController extends GetxController {
  RxBool isLoading = false.obs;
  final repo = TaskRepository();

  void deleteTask(BuildContext context, {required int taskId}) async {
    try {
      isLoading.value = true;
      final result = await repo.deleteTask(
        id: taskId,
      );
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
