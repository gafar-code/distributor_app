import 'dart:convert';
import 'dart:developer';

import 'package:distributor_app/app_constants.dart';
import 'package:distributor_app/models/error_model.dart';
import 'package:distributor_app/models/general_model.dart';
import 'package:distributor_app/models/proof_model.dart';
import 'package:distributor_app/utils/failure.dart';
import 'package:distributor_app/utils/prefs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/either.dart';

final class ProofRepository {
  final prefs = Get.find<PrefsService>().prefs;

  Future<Either<Failure, ProofListModel>> getProofs(
      {int? paginationId, required int? taskId}) async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/task_proof')
        .replace(queryParameters: {
      if (paginationId != null) 'pagination_id': paginationId.toString(),
      'task_id': taskId.toString()
    });
    final token = prefs.getString('token');
    try {
      final res = await http.get(endpoint, headers: {
        'Authorization': 'Bearer $token',
      });
      log(res.body);
      if (res.statusCode == 200) {
        return Either.success(proofListModelFromJson(res.body));
      } else {
        return Either.error(Failure(errorModelFromJson(res.body).message));
      }
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, GeneralModel>> addProof(
      {required ProofParams params}) async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/task_proof');
    final token = prefs.getString('token');
    try {
      final res = await http.post(endpoint,
          body: jsonEncode({
            'task_id': params.taskId,
            "description": params.description,
            "image": params.imagePath,
            "latitude": params.lat,
            "longitude": params.lng,
            "address": params.address
          }),
          headers: {
            'Authorization': 'Bearer $token',
          });
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

  Future<Either<Failure, GeneralModel>> editProof(
      {required int taskProofId, String? description}) async {
    final endpoint =
        Uri.parse('${AppConstants.apiBaseUrl}/task_proof/$taskProofId');
    final token = prefs.getString('token');
    try {
      final res = await http.put(endpoint,
          body: jsonEncode({
            if (description != null) "description": description,
          }),
          headers: {
            'Authorization': 'Bearer $token',
          });
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

  Future<Either<Failure, GeneralModel>> deleteProof({required int id}) async {
    final endpoint = Uri.parse('${AppConstants.apiBaseUrl}/task_proof/$id');
    final token = prefs.getString('token');
    try {
      final res = await http.delete(endpoint, headers: {
        'Authorization': 'Bearer $token',
      });
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

final class ProofParams {
  final int? taskId;
  final String? description;
  final String? address;
  final double? lat;
  final double? lng;
  final String? imagePath;

  ProofParams(
      {this.taskId,
      this.description,
      this.address,
      this.lat,
      this.lng,
      this.imagePath});
}
