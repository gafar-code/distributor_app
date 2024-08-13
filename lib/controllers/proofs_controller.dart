import 'package:distributor_app/models/proof_model.dart';
import 'package:distributor_app/repositories/proof_repository.dart';
import 'package:get/get.dart';

import '../utils/helper.dart';

final class ProofsController extends GetxController {
  RxBool isLoading = false.obs;
  final repo = ProofRepository();
  List<ProofDatum> data = [];

  void getProofs(int taskId) async {
    try {
      isLoading.value = true;
      final result = await repo.getProofs(taskId: taskId);
      result.when(error: (e) async {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        data = s.data;
      });
    } finally {
      isLoading.value = false;
    }
  }
}
