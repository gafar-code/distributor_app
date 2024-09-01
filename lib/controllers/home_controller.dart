import 'dart:developer';
import 'package:distributor_app/models/task_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../repositories/task_repository.dart';
import '../utils/helper.dart';

final class HomeController extends GetxController {
  final isLoading = false.obs;
  final repo = TaskRepository();
  final refreshController = RefreshController(initialRefresh: false);

  final tasks = <Task>[].obs;
  RxInt totalPendingTaskCount = 0.obs;
  RxInt completedTaskCount = 0.obs;
  RxInt scheduledTaskCount = 0.obs;
  RxBool hasMoreData = true.obs;

  int? lastTaskId; // For manual pagination
  TaskFilterParams? currentFilterParams; // Store the current filter state

  @override
  void onInit() {
    super.onInit();
    loadInitialTasks(); // Initial load without any filter
  }

  void loadWithRemovedFilters() async {
    currentFilterParams = null; // Store the applied filter

    loadInitialTasks();
  }

  void loadInitialTasks() async {
    try {
      log("Loading initial tasks");
      isLoading.value = true;
      lastTaskId = null; // Reset pagination
      tasks.clear();
      refreshController.resetNoData(); // Clear previous tasks

      final result = await repo.getTasks(
          paginationId: 0,
          filterParams: currentFilterParams // Use stored filter params
          );

      result.when(
        error: (e) async {
          showCustomSnackbar(e.message);
          refreshController.refreshFailed();
        },
        success: (s) async {
          totalPendingTaskCount.value = s.data.totalPending;
          completedTaskCount.value = s.data.totalSuccess;
          scheduledTaskCount.value = s.data.totalScheduled;

          final fetchedTasks = s.data.tasks;
          tasks.addAll(fetchedTasks);

          if (fetchedTasks.isEmpty) {
            refreshController.loadNoData();
          } else {
            lastTaskId =
                fetchedTasks.last.id; // Set last task ID for pagination
            refreshController.refreshCompleted();
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  void loadMoreTasks() async {
    if (lastTaskId == null) {
      refreshController.loadNoData();
      return;
    }

    try {
      log("Loading more tasks with lastTaskId: $lastTaskId and current filter");

      final result = await repo.getTasks(
          paginationId: lastTaskId!,
          filterParams: currentFilterParams // Use stored filter params
          );

      result.when(
        error: (e) async {
          showCustomSnackbar(e.message);
          refreshController.loadFailed();
        },
        success: (s) async {
          final fetchedTasks = s.data.tasks;
          if (fetchedTasks.isEmpty) {
            refreshController.loadNoData();
          } else {
            tasks.addAll(fetchedTasks);
            lastTaskId =
                fetchedTasks.last.id; // Update last task ID for pagination
            refreshController.loadComplete();
          }
        },
      );
    } finally {}
  }

  void applyFilter(TaskFilterParams filterParams) {
    log("Applying new filter: $filterParams");

    currentFilterParams = filterParams; // Store the applied filter

    loadInitialTasks(); // Load tasks with the applied filter
  }

  @override
  void onClose() {
    refreshController.dispose(); // Dispose of the RefreshController
    super.onClose();
  }
}
