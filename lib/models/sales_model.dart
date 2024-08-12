import 'dart:convert';

SalesModel salesModelFromJson(String str) =>
    SalesModel.fromJson(json.decode(str));

class SalesModel {
  final List<SalesDatum> data;

  SalesModel({
    required this.data,
  });

  factory SalesModel.fromJson(Map<String, dynamic> json) => SalesModel(
        data: List<SalesDatum>.from(
            json["data"].map((x) => SalesDatum.fromJson(x))),
      );
}

class SalesDatum {
  final int id;
  final String name;

  SalesDatum({
    required this.id,
    required this.name,
  });

  factory SalesDatum.fromJson(Map<String, dynamic> json) => SalesDatum(
        id: json["id"],
        name: json["name"],
      );
}
