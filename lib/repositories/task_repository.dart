import 'dart:convert';
import 'dart:developer';

import 'package:distributor_app/app_constants.dart';
import 'package:distributor_app/models/error_model.dart';
import 'package:distributor_app/models/general_model.dart';
import 'package:distributor_app/models/task_model.dart';
import 'package:distributor_app/utils/failure.dart';
import 'package:distributor_app/utils/prefs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/either.dart';

final class TaskRepository {
  final prefs = Get.find<PrefsService>().prefs;

  Future<Either<Failure, TaskListModel>> getTasks(
      {required int paginationId}) async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/task')
        .replace(queryParameters: {'pagination_id': paginationId.toString()});
    final token = prefs.getString('token');
    try {
      final res = await http.get(endpoint, headers: {
        'Authorization': 'Bearer $token',
      });
      log(res.body);
      if (res.statusCode == 200) {
        return Either.success(taskListModelFromJson(res.body));
      } else {
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, TaskModel>> getDetailTask({required int id}) async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/task/{$id}');
    final token = prefs.getString('token');
    try {
      final res = await http.get(endpoint, headers: {
        'Authorization': 'Bearer $token',
      });
      log(res.body);
      if (res.statusCode == 200) {
        return Either.success(taskModelFromJson(res.body));
      } else {
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, GeneralModel>> addTask(
      {required TaskParams params}) async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/task');
    final token = prefs.getString('token');
    try {
      final res = await http.post(endpoint,
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'title': params.title,
            'body': params.description,
            'sales_id': params.salesId,
          }));
      log(res.body);
      if (res.statusCode == 200) {
        return Either.success(generalModelFromJson(res.body));
      } else {
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, GeneralModel>> editTask(
      {required TaskParams params}) async {
    final endpoint =
        Uri.parse('${AppConstants.apiBaseUrl}/task/${params.taskId}');
    final token = prefs.getString('token');
    try {
      final res = await http.put(endpoint,
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'title': params.title,
            'body': params.description,
            'sales_id': params.salesId,
            'status': params.status,
            'sales_name': params.salesName
          }));
      log(res.body);
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

final class TaskParams {
  final int? taskId;
  final int? salesId;
  final String? description;
  final String? title;
  final String? salesName;
  final String? status;

  TaskParams(
      {this.salesId,
      this.description,
      this.title,
      this.salesName,
      this.taskId,
      this.status});
}
