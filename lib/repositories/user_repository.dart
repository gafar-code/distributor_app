import 'dart:convert';
import 'dart:developer';

import 'package:distributor_app/app_constants.dart';

import 'package:distributor_app/models/error_model.dart';
import 'package:distributor_app/models/general_model.dart';
import 'package:distributor_app/models/user_model.dart';
import 'package:distributor_app/utils/failure.dart';
import 'package:distributor_app/utils/helper.dart';
import 'package:distributor_app/utils/prefs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../flutter_flow/nav/nav.dart';
import '../utils/either.dart';

final class UserRepository {
  final prefs = Get.find<PrefsService>().prefs;

  Future<Either<Failure, UserModel>> getUserData() async {
    final userId = prefs.getInt('userId');
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/user/$userId');
    final token = prefs.getString('token');
    try {
      final res = await http.get(endpoint, headers: {
        'Authorization': 'Bearer $token',
      }).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
      );
      log(res.body);
      if (res.statusCode == 200) {
        return Either.success(UserModel.fromJson(jsonDecode(res.body)));
      } else {
        if (errorModelFromJson(res.body).code == 401) {
          clearControllers();
          prefs.clear();
          navigatorKey.currentContext
              ?.goNamed('LoginPage', extra: {'clearStack': true});
        }
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, GeneralModel>> updateUserData(
      {required UserParams params}) async {
    final userId = prefs.getInt('userId');
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/user/$userId');
    final token = prefs.getString('token');
    try {
      final res = await http
          .put(endpoint,
              headers: {
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({
                if (params.name != null) 'name': params.name,
                if (params.email != null) 'email': params.email,
                if (params.gender != null) 'gender': params.gender,
                if (params.phone != null) 'phone': params.phone,
              }))
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
      );

      log(
        res.body,
      );
      if (res.statusCode == 200) {
        return Either.success(generalModelFromJson(res.body));
      } else {
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }
}

final class UserParams {
  final String? name;
  final String? gender;
  final String? phone;
  final String? email;

  UserParams({
    this.name,
    this.gender,
    this.phone,
    this.email,
  });
}
