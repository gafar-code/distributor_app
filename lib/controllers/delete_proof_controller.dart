import 'package:distributor_app/repositories/file_repository.dart';
import 'package:distributor_app/repositories/proof_repository.dart';
import 'package:distributor_app/utils/helper.dart';
import 'package:get/get.dart';

import '../utils/location_service.dart';

final class DeleteProofController extends GetxController {
  final locaationService = LocationService();
  RxBool isLoading = false.obs;
  final repo = ProofRepository();
  final fileRepo = UploadFileRepository();

  void deleteProof({required int proofId, required String fileName}) async {
    try {
      isLoading.value = true;
      await deleteFile(fileName);

      final result = await repo.deleteProof(id: proofId);
      result.when(error: (e) async {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        showCustomSnackbar(s.message);
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteFile(String fileName) async {
    final result = await fileRepo.deleteImage(fileName: fileName);
    result.when(
        error: (e) async {
          showCustomSnackbar(e.message);
        },
        success: (s) async {});
  }
}
