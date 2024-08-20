import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:distributor_app/repositories/auth_repository.dart';
import 'package:distributor_app/utils/helper.dart';
import 'package:distributor_app/utils/prefs.dart';
import 'package:get/get.dart';

final class LogoutController extends GetxController {
  RxBool isLoading = false.obs;
  final repo = AuthRepository();
  final prefs = Get.find<PrefsService>().prefs;

  void logout() async {
    try {
      isLoading.value = true;
      final result = await repo.logout();
      result.when(error: (e) async {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        clearControllers();
        await prefs.clear();
        navigatorKey.currentContext
            ?.go('/loginPage', extra: {'clearStack': true});
      });
    } finally {
      isLoading.value = false;
    }
  }
}
