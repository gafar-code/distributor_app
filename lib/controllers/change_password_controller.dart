import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:distributor_app/repositories/auth_repository.dart';
import 'package:distributor_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class ChangePasswordController extends GetxController {
  final oldPasswordC = TextEditingController();
  final newPasswordC = TextEditingController();
  final confirmPasswordC = TextEditingController();
  RxBool isLoading = false.obs;
  final repo = AuthRepository();

  void changePassword(BuildContext context) async {
    try {
      isLoading.value = true;
      final result = await repo.changePassword(
          oldPassword: oldPasswordC.text, newPaswword: newPasswordC.text);
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
