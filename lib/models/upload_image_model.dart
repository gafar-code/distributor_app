// To parse this JSON data, do
//
//     final uploadImageModel = uploadImageModelFromJson(jsonString);

import 'dart:convert';

UploadImageModel uploadImageModelFromJson(String str) =>
    UploadImageModel.fromJson(json.decode(str));

class UploadImageModel {
  final String message;
  final UploadImageDatum data;

  UploadImageModel({
    required this.message,
    required this.data,
  });

  factory UploadImageModel.fromJson(Map<String, dynamic> json) =>
      UploadImageModel(
        message: json["message"],
        data: UploadImageDatum.fromJson(json["data"]),
      );
}

class UploadImageDatum {
  final String name;

  UploadImageDatum({
    required this.name,
  });

  factory UploadImageDatum.fromJson(Map<String, dynamic> json) =>
      UploadImageDatum(
        name: json["name"],
      );
}
