import 'package:distributor_app/controllers/home_controller.dart';
import 'package:distributor_app/controllers/proofs_controller.dart';
import 'package:distributor_app/controllers/sales_controller.dart';
import 'package:distributor_app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalContextService {
  static late BuildContext context;

  static void init(BuildContext ctx) {
    context = ctx;
  }
}

dynamic showCustomSnackbar(String message) {
  ScaffoldMessenger.of(GlobalContextService.context)
      .showSnackBar(SnackBar(content: Text(message)));
}

String getImageRemote(String path) {
  return 'https://distributor-backend.fly.dev/public/images/$path';
}

void clearControllers() async {
  await Get.delete<HomeController>();
  await Get.delete<ProofsController>();
  await Get.delete<SalesContoller>();
  await Get.delete<UserController>();
}
