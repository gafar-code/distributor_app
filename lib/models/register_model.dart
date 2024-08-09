import 'dart:convert';

import 'login_model.dart';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

class RegisterModel {
  final RegisterDatum data;

  RegisterModel({
    required this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        data: RegisterDatum.fromJson(json["data"]),
      );
}

class RegisterDatum {
  final String token;
  final User user;

  RegisterDatum({
    required this.token,
    required this.user,
  });

  factory RegisterDatum.fromJson(Map<String, dynamic> json) => RegisterDatum(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );
}
