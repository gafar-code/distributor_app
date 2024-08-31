import 'dart:developer';

import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:distributor_app/models/error_model.dart';
import 'package:distributor_app/models/general_model.dart';
import 'package:distributor_app/models/task_model.dart';
import 'package:distributor_app/utils/failure.dart';
import 'package:distributor_app/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/either.dart';
import '../utils/helper.dart';

final class TaskRepository {
  final prefs = Get.find<PrefsService>().prefs;

  Future<Either<Failure, TaskListModel>> getTasks(
      {required int paginationId, TaskFilterParams? filterParams}) async {
    final queryParameters = {
      'pagination_id': paginationId.toString(),
      if (filterParams?.dateRange != null)
        'start_date':
            '${DateFormat('yyyy-MM-dd').format(filterParams!.dateRange!.start)}T',
      if (filterParams?.dateRange != null)
        'end_date':
            '${DateFormat('yyyy-MM-dd').format(filterParams!.dateRange!.end)}T',
      if (filterParams?.scheduleAt != null)
        'scheduled_at':
            '${DateFormat('yyyy-MM-dd').format(filterParams!.scheduleAt!)}T',
      if (filterParams?.salesId != null)
        'sales_id': filterParams!.salesId.toString()
    };
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/task')
        .replace(queryParameters: queryParameters);
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
        return Either.success(taskListModelFromJson(res.body));
      } else {
        if (errorModelFromJson(res.body).code == 401) {
          clearControllers();
          await prefs.clear();
          navigatorKey.currentContext
              ?.goNamed('LoginPage', extra: {'clearStack': true});
          return Either.error(Failure('token invalid, silakan login ulang'));
        }
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, TaskModel>> getDetailTask({required int id}) async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/task/$id');
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
        return Either.success(taskModelFromJson(res.body));
      } else {
        if (errorModelFromJson(res.body).code == 401) {
          clearControllers();
          await prefs.clear();
          navigatorKey.currentContext
              ?.goNamed('LoginPage', extra: {'clearStack': true});
          return Either.error(Failure('token invalid, silakan login ulang'));
        }
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
      final res = await http
          .post(endpoint,
              headers: {
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({
                'title': params.title,
                'body': params.description,
                'sales_id': params.salesId,
                'scheduled_at':
                    '${DateFormat('yyyy-MM-dd').format(params.scheduleAt!)}T'
              }))
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
      );
      log(res.body);
      if (res.statusCode == 200) {
        return Either.success(generalModelFromJson(res.body));
      } else {
        if (errorModelFromJson(res.body).code == 401) {
          clearControllers();
          await prefs.clear();
          navigatorKey.currentContext
              ?.goNamed('LoginPage', extra: {'clearStack': true});
          return Either.error(Failure('token invalid, silakan login ulang'));
        }
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
      final res = await http
          .put(endpoint,
              headers: {
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({
                'title': params.title,
                'body': params.description,
                'sales_id': params.salesId,
                'status': params.status,
                'sales_name': params.salesName,
                if (params.scheduleAt != null)
                  'scheduled_at':
                      '${DateFormat('yyyy-MM-dd').format(params.scheduleAt!)}T'
              }))
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
      );
      log(res.body);
      if (res.statusCode == 200) {
        return Either.success(generalModelFromJson(res.body));
      } else {
        if (errorModelFromJson(res.body).code == 401) {
          clearControllers();
          await prefs.clear();
          navigatorKey.currentContext
              ?.goNamed('LoginPage', extra: {'clearStack': true});
          return Either.error(Failure('token invalid, silakan login ulang'));
        }
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, GeneralModel>> deleteTask({required int id}) async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/task/$id');
    final token = prefs.getString('token');
    try {
      final res = await http.delete(endpoint, headers: {
        'Authorization': 'Bearer $token',
      }).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
      );
      log(res.body);
      if (res.statusCode == 200) {
        return Either.success(generalModelFromJson(res.body));
      } else {
        if (errorModelFromJson(res.body).code == 401) {
          clearControllers();
          await prefs.clear();
          navigatorKey.currentContext
              ?.goNamed('LoginPage', extra: {'clearStack': true});
          return Either.error(Failure('token invalid, silakan login ulang'));
        }
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }
}

final class TaskFilterParams {
  final DateTimeRange? dateRange;
  final DateTime? scheduleAt;
  final int? salesId;

  TaskFilterParams({this.dateRange, this.scheduleAt, this.salesId});
}

final class TaskParams {
  final int? taskId;
  final int? salesId;
  final String? description;
  final String? title;
  final String? salesName;
  final String? status;
  final DateTime? scheduleAt;

  TaskParams(
      {this.salesId,
      this.description,
      this.title,
      this.salesName,
      this.taskId,
      this.scheduleAt,
      this.status});
}
