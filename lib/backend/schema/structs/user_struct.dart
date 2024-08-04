// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserStruct extends BaseStruct {
  UserStruct({
    String? createdAt,
    String? email,
    String? fcmToken,
    int? id,
    String? name,
    String? role,
    String? updatedAt,
  })  : _createdAt = createdAt,
        _email = email,
        _fcmToken = fcmToken,
        _id = id,
        _name = name,
        _role = role,
        _updatedAt = updatedAt;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "fcm_token" field.
  String? _fcmToken;
  String get fcmToken => _fcmToken ?? '';
  set fcmToken(String? val) => _fcmToken = val;

  bool hasFcmToken() => _fcmToken != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  set role(String? val) => _role = val;

  bool hasRole() => _role != null;

  // "updated_at" field.
  String? _updatedAt;
  String get updatedAt => _updatedAt ?? '';
  set updatedAt(String? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  static UserStruct fromMap(Map<String, dynamic> data) => UserStruct(
        createdAt: data['created_at'] as String?,
        email: data['email'] as String?,
        fcmToken: data['fcm_token'] as String?,
        id: castToType<int>(data['id']),
        name: data['name'] as String?,
        role: data['role'] as String?,
        updatedAt: data['updated_at'] as String?,
      );

  static UserStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'created_at': _createdAt,
        'email': _email,
        'fcm_token': _fcmToken,
        'id': _id,
        'name': _name,
        'role': _role,
        'updated_at': _updatedAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'fcm_token': serializeParam(
          _fcmToken,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'role': serializeParam(
          _role,
          ParamType.String,
        ),
        'updated_at': serializeParam(
          _updatedAt,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserStruct(
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        fcmToken: deserializeParam(
          data['fcm_token'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        role: deserializeParam(
          data['role'],
          ParamType.String,
          false,
        ),
        updatedAt: deserializeParam(
          data['updated_at'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserStruct &&
        createdAt == other.createdAt &&
        email == other.email &&
        fcmToken == other.fcmToken &&
        id == other.id &&
        name == other.name &&
        role == other.role &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([createdAt, email, fcmToken, id, name, role, updatedAt]);
}

UserStruct createUserStruct({
  String? createdAt,
  String? email,
  String? fcmToken,
  int? id,
  String? name,
  String? role,
  String? updatedAt,
}) =>
    UserStruct(
      createdAt: createdAt,
      email: email,
      fcmToken: fcmToken,
      id: id,
      name: name,
      role: role,
      updatedAt: updatedAt,
    );
