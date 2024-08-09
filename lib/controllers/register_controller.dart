import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:distributor_app/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/helper.dart';

final class RegisterController extends GetxController {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();
  RxBool isLoading = false.obs;
  final repo = AuthRepository();

  void clearFields() {
    nameC.clear();
    emailC.clear();
    passwordC.clear();
    confirmPasswordC.clear();
  }

  void register(BuildContext context, {required String role}) async {
    try {
      isLoading.value = true;
      final result = await repo.register(RegisterParams(
          role: role,
          name: nameC.text,
          email: emailC.text,
          password: confirmPasswordC.text));
      result.when(error: (e) {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        context.pop();
        clearFields();
        showCustomSnackbar('Registrasi berhasil');
      });
    } finally {
      isLoading.value = false;
    }
  }
}
