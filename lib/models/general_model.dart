import 'dart:convert';

GeneralModel generalModelFromJson(String str) =>
    GeneralModel.fromJson(json.decode(str));

class GeneralModel {
  final String message;

  GeneralModel({
    required this.message,
  });

  factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
        message: json["message"],
      );
}
