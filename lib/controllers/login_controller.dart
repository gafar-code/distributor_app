import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:distributor_app/repositories/auth_repository.dart';
import 'package:distributor_app/utils/helper.dart';
import 'package:distributor_app/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class LoginController extends GetxController {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  RxBool isLoading = false.obs;
  final repo = AuthRepository();
  final prefs = Get.find<PrefsService>().prefs;

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  void login(BuildContext context) async {
    try {
      isLoading.value = true;
      final result =
          await repo.login(email: emailC.text, password: passwordC.text);
      result.when(error: (e) async {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        prefs.setString('token', s.data.token);
        prefs.setString('role', s.data.user.role);
        emailC.clear();
        passwordC.clear();
        context.go(s.data.user.role == 'ADMIN' ? '/homeAdmin' : '/homeSales',
            extra: {'clearStack': true});
      });
    } finally {
      isLoading.value = false;
    }
  }
}
