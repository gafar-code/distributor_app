import 'dart:convert';
import 'dart:developer';

import 'package:distributor_app/app_constants.dart';
import 'package:distributor_app/models/error_model.dart';
import 'package:distributor_app/models/general_model.dart';
import 'package:distributor_app/models/login_model.dart';
import 'package:distributor_app/models/register_model.dart';
import 'package:distributor_app/utils/failure.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/either.dart';
import '../utils/prefs.dart';

final class AuthRepository {
  final prefs = Get.find<PrefsService>().prefs;

  Future<Either<Failure, LoginModel>> login(
      {required String email, required String password}) async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/auth/login');
    try {
      final res = await http.post(endpoint,
          body: jsonEncode({'email': email, 'password': password}));

      if (res.statusCode == 200) {
        return Either.success(loginModelFromJson(res.body));
      } else {
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, RegisterModel>> register(RegisterParams params) async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/auth/register');
    try {
      final res = await http.post(endpoint,
          body: jsonEncode({
            'email': params.email,
            'password': params.password,
            'role': params.role,
            'name': params.name
          }));
      if (res.statusCode == 200) {
        return Either.success(registerModelFromJson(res.body));
      } else {
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, GeneralModel>> forgotPassword(
      {required String email}) async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/auth/forgot');
    try {
      final res = await http.post(endpoint,
          body: jsonEncode({
            'email': email,
          }));

      if (res.statusCode == 200) {
        return Either.success(generalModelFromJson(res.body));
      } else {
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, GeneralModel>> changePassword(
      {required String oldPassword, required String newPaswword}) async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/auth/change');
    final token = prefs.getString('token');
    log(token ?? 'kosong');
    try {
      final res = await http.put(endpoint,
          body: jsonEncode(
              {'old_password': oldPassword, 'new_password': newPaswword}),
          headers: {
            'Authorization': 'Bearer $token',
          });
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

final class RegisterParams {
  final String role;
  final String name;
  final String email;
  final String password;

  RegisterParams(
      {required this.role,
      required this.name,
      required this.email,
      required this.password});
}
