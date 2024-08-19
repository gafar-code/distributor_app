import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

class LoginModel {
  final LoginDatum data;

  LoginModel({
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: LoginDatum.fromJson(json["data"]),
      );
}

class LoginDatum {
  final String token;
  final User user;

  LoginDatum({
    required this.token,
    required this.user,
  });

  factory LoginDatum.fromJson(Map<String, dynamic> json) => LoginDatum(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );
}

class User {
  final DateTime createdAt;
  final String email;
  final String fcmToken;
  final int id;
  final String name;
  final String role;
  final String phone;
  final String gender;
  final DateTime updatedAt;

  User({
    required this.phone,
    required this.gender,
    required this.createdAt,
    required this.email,
    required this.fcmToken,
    required this.id,
    required this.name,
    required this.role,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        createdAt: DateTime.parse(json["created_at"]),
        email: json["email"],
        fcmToken: json["fcm_token"],
        id: json["id"],
        name: json["name"],
        role: json["role"],
        gender: json['gender'],
        phone: json['phone'],
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
