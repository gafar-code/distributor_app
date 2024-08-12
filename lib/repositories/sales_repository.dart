import 'dart:developer';

import 'package:distributor_app/app_constants.dart';
import 'package:distributor_app/models/error_model.dart';
import 'package:distributor_app/models/sales_model.dart';
import 'package:distributor_app/utils/failure.dart';
import 'package:distributor_app/utils/prefs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/either.dart';

final class SalesRepository {
  final prefs = Get.find<PrefsService>().prefs;

  Future<Either<Failure, SalesModel>> getSales(
      {int? paginationId, String? name}) async {
    final endpoint =
        Uri.parse('${AppConstants.apiBaseUrl}/sales').replace(queryParameters: {
      if (paginationId != null) 'pagination_id': paginationId.toString(),
      if (name != null) 'name': name.toString()
    });
    final token = prefs.getString('token');
    try {
      final res = await http.get(endpoint, headers: {
        'Authorization': 'Bearer $token',
      });
      log(res.body);
      if (res.statusCode == 200) {
        return Either.success(salesModelFromJson(res.body));
      } else {
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }
}
