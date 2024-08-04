// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LoginResponseStruct extends BaseStruct {
  LoginResponseStruct({
    int? code,
    String? message,
    DataStruct? data,
  })  : _code = code,
        _message = message,
        _data = data;

  // "code" field.
  int? _code;
  int get code => _code ?? 0;
  set code(int? val) => _code = val;

  void incrementCode(int amount) => code = code + amount;

  bool hasCode() => _code != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "data" field.
  DataStruct? _data;
  DataStruct get data => _data ?? DataStruct();
  set data(DataStruct? val) => _data = val;

  void updateData(Function(DataStruct) updateFn) {
    updateFn(_data ??= DataStruct());
  }

  bool hasData() => _data != null;

  static LoginResponseStruct fromMap(Map<String, dynamic> data) =>
      LoginResponseStruct(
        code: castToType<int>(data['code']),
        message: data['message'] as String?,
        data: DataStruct.maybeFromMap(data['data']),
      );

  static LoginResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? LoginResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'code': _code,
        'message': _message,
        'data': _data?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'code': serializeParam(
          _code,
          ParamType.int,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'data': serializeParam(
          _data,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static LoginResponseStruct fromSerializableMap(Map<String, dynamic> data) =>
      LoginResponseStruct(
        code: deserializeParam(
          data['code'],
          ParamType.int,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        data: deserializeStructParam(
          data['data'],
          ParamType.DataStruct,
          false,
          structBuilder: DataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'LoginResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LoginResponseStruct &&
        code == other.code &&
        message == other.message &&
        data == other.data;
  }

  @override
  int get hashCode => const ListEquality().hash([code, message, data]);
}

LoginResponseStruct createLoginResponseStruct({
  int? code,
  String? message,
  DataStruct? data,
}) =>
    LoginResponseStruct(
      code: code,
      message: message,
      data: data ?? DataStruct(),
    );
