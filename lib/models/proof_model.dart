// To parse this JSON data, do
//
//     final proofModel = proofModelFromJson(jsonString);

import 'dart:convert';

ProofModel proofModelFromJson(String str) =>
    ProofModel.fromJson(json.decode(str));

ProofListModel proofListModelFromJson(String str) =>
    ProofListModel.fromJson(json.decode(str));

String proofModelToJson(ProofModel data) => json.encode(data.toJson());

class ProofListModel {
  final List<ProofDatum> data;

  ProofListModel({
    required this.data,
  });

  factory ProofListModel.fromJson(Map<String, dynamic> json) => ProofListModel(
        data: List<ProofDatum>.from(
            json["data"].map((x) => ProofDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ProofModel {
  final ProofDatum data;

  ProofModel({
    required this.data,
  });

  factory ProofModel.fromJson(Map<String, dynamic> json) => ProofModel(
        data: ProofDatum.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class ProofDatum {
  final int id;
  final int taskId;
  final int salesId;
  final String salesName;
  final String description;
  final String image;
  final double latitude;
  final double longitude;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProofDatum({
    required this.id,
    required this.taskId,
    required this.salesId,
    required this.salesName,
    required this.description,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProofDatum.fromJson(Map<String, dynamic> json) => ProofDatum(
        id: json["id"],
        taskId: json["task_id"],
        salesId: json["sales_id"],
        salesName: json["sales_name"],
        description: json["description"],
        image: json["image"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task_id": taskId,
        "sales_id": salesId,
        "sales_name": salesName,
        "description": description,
        "image": image,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
