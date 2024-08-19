import 'package:distributor_app/controllers/user_controller.dart';
import 'package:distributor_app/repositories/user_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../utils/helper.dart';

final class UpdateUserController extends GetxController {
  RxBool isLoading = false.obs;
  final repo = UserRepository();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final nameC = TextEditingController();

  void updateUserData({String? gender}) async {
    try {
      isLoading.value = true;
      final result = await repo.updateUserData(
          params: UserParams(
              name: nameC.text,
              phone: phoneC.text,
              email: emailC.text,
              gender: gender));
      result.when(error: (e) async {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        showCustomSnackbar(s.message);
        Get.find<UserController>().getUserData();
      });
    } finally {
      isLoading.value = false;
    }
  }
}
