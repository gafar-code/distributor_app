import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:distributor_app/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/helper.dart';

final class RegisterController extends GetxController {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();
  RxBool isLoading = false.obs;
  final repo = AuthRepository();
  late SharedPreferences prefs;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

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
        showCustomSnackbar('Registrasi berhasil');
        prefs.setString('token', s.data.token);
        prefs.setString('role', s.data.user.role);
        context.go(s.data.user.role == 'ADMIN' ? '/homeAdmin' : '/homeSales',
            extra: {'clearStack': true});
        clearFields();
      });
    } finally {
      isLoading.value = false;
    }
  }
}
