import 'package:distributor_app/repositories/auth_repository.dart';
import 'package:distributor_app/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/helper.dart';

final class RegisterController extends GetxController {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();
  RxBool isLoading = false.obs;
  final repo = AuthRepository();
  final prefs = Get.find<PrefsService>().prefs;

  void clearFields() {
    nameC.clear();
    emailC.clear();
    passwordC.clear();
    confirmPasswordC.clear();
    phoneC.clear();
  }

  void register(BuildContext context,
      {required String role, required String gender}) async {
    try {
      isLoading.value = true;
      final result = await repo.register(RegisterParams(
          gender: gender,
          role: role,
          name: nameC.text,
          email: emailC.text,
          phone: phoneC.text,
          password: confirmPasswordC.text));
      result.when(error: (e) {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        showCustomSnackbar('Tambah Pengguna berhasil');
        clearFields();
      });
    } finally {
      isLoading.value = false;
    }
  }
}
