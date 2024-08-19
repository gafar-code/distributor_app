import 'package:distributor_app/models/login_model.dart';
import 'package:distributor_app/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../utils/helper.dart';

final class UserController extends GetxController {
  RxBool isLoading = false.obs;
  final repo = UserRepository();
  Rxn<User> data = Rxn<User>();

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  void getUserData() async {
    try {
      isLoading.value = true;
      final result = await repo.getUserData();
      result.when(error: (e) async {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        data.value = s.data;
      });
    } finally {
      isLoading.value = false;
    }
  }
}
