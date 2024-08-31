import 'dart:developer';

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
  RxInt scheduledTaskCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    log("Controller initialized, adding initial page request listener");
    pagingController.addPageRequestListener(fetchPage);
  }

  void refreshTasks() {
    log("Refreshing tasks, clearing previous data");
    pagingController.refresh();
  }

  void fetchPage(int pageKey) {
    getTasks(
        pageKey); // This will call the existing getTasks method without filters
  }

  void getTasks(int paginationId, {TaskFilterParams? filterParams}) async {
    try {
      log("Fetching tasks with paginationId: $paginationId");
      isLoading.value = true;
      final result = await repo.getTasks(
          paginationId: paginationId, filterParams: filterParams);
      result.when(error: (e) async {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        totalPendingTaskCount.value = s.data.totalPending;
        completedTaskCount.value = s.data.totalSuccess;
        scheduledTaskCount.value = s.data.totalScheduled;
        final tasks = s.data.tasks;
        final isLastPage = tasks.isEmpty;
        if (isLastPage) {
          pagingController.appendLastPage(tasks);
        } else {
          final nextPageKey = tasks.last.id;
          pagingController.appendPage(tasks, nextPageKey);
        }
        isLoading.value = false;
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
