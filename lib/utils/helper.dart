import 'package:flutter/material.dart';

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
