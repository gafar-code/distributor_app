import 'package:distributor_app/models/sales_model.dart';
import 'package:distributor_app/repositories/sales_repository.dart';
import 'package:get/get.dart';

import '../utils/helper.dart';

final class SalesContoller extends GetxController {
  RxBool isLoading = false.obs;
  final repo = SalesRepository();
  List<SalesDatum> data = [];

  @override
  void onInit() {
    getSales();
    super.onInit();
  }

  void getSales() async {
    try {
      isLoading.value = true;
      final result = await repo.getSales();
      result.when(error: (e) async {
        showCustomSnackbar(e.message);
      }, success: (s) async {
        data = s.data;
      });
    } finally {
      isLoading.value = false;
    }
  }
}
