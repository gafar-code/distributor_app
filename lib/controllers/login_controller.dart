import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:distributor_app/repositories/auth_repository.dart';
import 'package:distributor_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LoginController extends GetxController {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  RxBool isLoading = false.obs;
  final repo = AuthRepository();
  late SharedPreferences prefs;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
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
        context.go(s.data.user.role == 'Admin' ? '/homeAdmin' : '/homeSales',
            extra: {'clearStack': true});
      });
    } finally {
      isLoading.value = false;
    }
  }
}
