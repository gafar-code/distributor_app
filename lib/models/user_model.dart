import 'package:distributor_app/models/login_model.dart';

class UserModel {
  final User data;

  UserModel({required this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: User.fromJson(json['data']),
      );
}
