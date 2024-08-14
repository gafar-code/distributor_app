import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:distributor_app/models/general_model.dart';
import 'package:distributor_app/models/upload_image_model.dart';
import 'package:distributor_app/utils/failure.dart';
import 'package:get/get.dart';

import '../app_constants.dart';
import '../utils/either.dart';
import '../utils/prefs.dart';

final class UploadFileRepository {
  final prefs = Get.find<PrefsService>().prefs;

  Future<Either<Failure, UploadImageModel>> uploadImage(
      {required File image}) async {
    const endpoint = '${AppConstants.apiBaseUrl}/file/image';
    final token = prefs.getString('token');
    try {
      var formData = dio.FormData.fromMap({
        "image": await dio.MultipartFile.fromFile(image.path),
        "name": image.path.split('/').last,
      });

      final response = await dio.Dio()
          .post(
        endpoint,
        data: formData,
        options: dio.Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
      );
      log(jsonEncode(response.data), name: 'res upload image');
      return Either.success(
          uploadImageModelFromJson(jsonEncode(response.data)));
    } catch (e) {
      log(e.toString(), name: 'upload image err');
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, UploadImageModel>> editImage({
    required String fileName,
    required File newImage,
  }) async {
    final endpoint = '${AppConstants.apiBaseUrl}/file/image/$fileName';
    final token = prefs.getString('token');
    try {
      var formData = dio.FormData.fromMap({
        "image": await dio.MultipartFile.fromFile(newImage.path),
        "name": newImage.path.split('/').last,
      });
      final response = await dio.Dio()
          .put(
        endpoint,
        data: formData,
        options: dio.Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
      );
      return Either.success(
          uploadImageModelFromJson(jsonEncode(response.data)));
    } catch (e) {
      return Either.error(Failure(e.toString()));
    }
  }

  Future<Either<Failure, GeneralModel>> deleteImage({
    required String fileName,
  }) async {
    final endpoint = '${AppConstants.apiBaseUrl}/file/image/$fileName';
    final token = prefs.getString('token');
    try {
      final response = await dio.Dio()
          .delete(
        endpoint,
        options: dio.Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      )
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw 'timeout exception';
        },
      );

      if (response.statusCode == 200) {
        return Either.success(generalModelFromJson(jsonEncode(response.data)));
      } else {
        return Either.error(Failure('Failed to delete the image.'));
      }
    } catch (e) {
      log(e.toString(), name: 'err delete file');
      return Either.error(Failure(e.toString()));
    }
  }
}
