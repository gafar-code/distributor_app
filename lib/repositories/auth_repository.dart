import 'dart:convert';
import 'dart:developer';

import 'package:distributor_app/app_constants.dart';
import 'package:distributor_app/backend/firebase/firebase_notification_service.dart';
import 'package:distributor_app/models/error_model.dart';
import 'package:distributor_app/models/general_model.dart';
import 'package:distributor_app/models/login_model.dart';
import 'package:distributor_app/models/register_model.dart';
import 'package:distributor_app/utils/failure.dart';
import 'package:distributor_app/utils/firebase_messaging_instance.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/either.dart';
import '../utils/prefs.dart';

final class AuthRepository {
  final prefs = Get.find<PrefsService>().prefs;
  final firebaseMessaging =
      Get.find<FirebaseMessagingInstance>().firebaseMessaging;

  Future<Either<Failure, LoginModel>> login(
      {required String email, required String password}) async {
    final notificationService =
        NotificationService(firebaseMessaging: firebaseMessaging);
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/auth/login');
    try {
      final res = await http
          .post(endpoint,
              body: jsonEncode({
                'email': email,
                'password': password,
                'fcm_token': await notificationService.getFirebaseToken()
              }))
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
      );
      log(res.body, name: 'login res');
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
    final notificationService =
        NotificationService(firebaseMessaging: firebaseMessaging);
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/auth/register');
    try {
      final res = await http
          .post(endpoint,
              body: jsonEncode({
                'email': params.email,
                'password': params.password,
                'role': params.role,
                'name': params.name,
                'fcm_token': await notificationService.getFirebaseToken()
              }))
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
      );
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
      final res = await http
          .post(endpoint,
              body: jsonEncode({
                'email': email,
              }))
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
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
          }).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
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

  Future<Either<Failure, GeneralModel>> logout() async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/auth/logout');
    final token = prefs.getString('token');
    try {
      final res = await http.post(endpoint, headers: {
        'Authorization': 'Bearer $token',
      }).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
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
