// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DataStruct extends BaseStruct {
  DataStruct({
    String? token,
    UserStruct? user,
  })  : _token = token,
        _user = user;

  // "token" field.
  String? _token;
  String get token => _token ?? '';
  set token(String? val) => _token = val;

  bool hasToken() => _token != null;

  // "user" field.
  UserStruct? _user;
  UserStruct get user => _user ?? UserStruct();
  set user(UserStruct? val) => _user = val;

  void updateUser(Function(UserStruct) updateFn) {
    updateFn(_user ??= UserStruct());
  }

  bool hasUser() => _user != null;

  static DataStruct fromMap(Map<String, dynamic> data) => DataStruct(
        token: data['token'] as String?,
        user: UserStruct.maybeFromMap(data['user']),
      );

  static DataStruct? maybeFromMap(dynamic data) =>
      data is Map ? DataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'token': _token,
        'user': _user?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'token': serializeParam(
          _token,
          ParamType.String,
        ),
        'user': serializeParam(
          _user,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static DataStruct fromSerializableMap(Map<String, dynamic> data) =>
      DataStruct(
        token: deserializeParam(
          data['token'],
          ParamType.String,
          false,
        ),
        user: deserializeStructParam(
          data['user'],
          ParamType.DataStruct,
          false,
          structBuilder: UserStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'DataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DataStruct && token == other.token && user == other.user;
  }

  @override
  int get hashCode => const ListEquality().hash([token, user]);
}

DataStruct createDataStruct({
  String? token,
  UserStruct? user,
}) =>
    DataStruct(
      token: token,
      user: user ?? UserStruct(),
    );
