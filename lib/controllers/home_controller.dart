import 'package:distributor_app/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../repositories/task_repository.dart';
import '../utils/helper.dart';

final class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  final repo = TaskRepository();
  final taskScrollController = ScrollController();
  final pagingController = PagingController<int, Task>(firstPageKey: 0);
  RxInt totalPendingTaskCount = 0.obs;
  RxInt completedTaskCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getTasks(pageKey);
    });
  }

  void getTasks(int paginationId) async {
    try {
      isLoading.value = true;
      final result = await repo.getTasks(paginationId: paginationId);
      result.when(error: (e) async {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        totalPendingTaskCount.value = s.data.totalPending;
        completedTaskCount.value = s.data.totalSuccess;
        final tasks = s.data.tasks;
        final isLastPage = tasks.isEmpty;
        if (isLastPage) {
          pagingController.appendLastPage(tasks);
        } else {
          final nextPageKey = tasks.last.id;
          pagingController.appendPage(tasks, nextPageKey);
        }
      });
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    taskScrollController.dispose();
    super.onClose();
  }
}
