import 'package:distributor_app/models/task_model.dart';
import 'package:get/get.dart';

import '../repositories/task_repository.dart';
import '../utils/helper.dart';

final class DetailTaskController extends GetxController {
  RxBool isLoading = false.obs;
  final repo = TaskRepository();
  Rxn<TaskModel> data = Rxn<TaskModel>();

  void getDetailTask(int id) async {
    try {
      isLoading.value = true;
      final result = await repo.getDetailTask(id: id);
      result.when(error: (e) async {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        data.value = s;
      });
    } finally {
      isLoading.value = false;
    }
  }
}
