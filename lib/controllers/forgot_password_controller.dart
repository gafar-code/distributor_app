import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:distributor_app/repositories/auth_repository.dart';
import 'package:distributor_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class ForgotPasswordController extends GetxController {
  final emailC = TextEditingController();
  RxBool isLoading = false.obs;
  final repo = AuthRepository();

  void forgotPassword(BuildContext context) async {
    try {
      isLoading.value = true;
      final result = await repo.forgotPassword(
        email: emailC.text,
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
