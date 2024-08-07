// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TasksStruct extends BaseStruct {
  TasksStruct({
    String? body,
    String? createdAt,
    int? id,
    int? salesId,
    String? salesName,
    String? status,
    String? title,
    String? updatedAt,
  })  : _body = body,
        _createdAt = createdAt,
        _id = id,
        _salesId = salesId,
        _salesName = salesName,
        _status = status,
        _title = title,
        _updatedAt = updatedAt;

  // "body" field.
  String? _body;
  String get body => _body ?? '';
  set body(String? val) => _body = val;

  bool hasBody() => _body != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "sales_id" field.
  int? _salesId;
  int get salesId => _salesId ?? 0;
  set salesId(int? val) => _salesId = val;

  void incrementSalesId(int amount) => salesId = salesId + amount;

  bool hasSalesId() => _salesId != null;

  // "sales_name" field.
  String? _salesName;
  String get salesName => _salesName ?? '';
  set salesName(String? val) => _salesName = val;

  bool hasSalesName() => _salesName != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "updated_at" field.
  String? _updatedAt;
  String get updatedAt => _updatedAt ?? '';
  set updatedAt(String? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  static TasksStruct fromMap(Map<String, dynamic> data) => TasksStruct(
        body: data['body'] as String?,
        createdAt: data['created_at'] as String?,
        id: castToType<int>(data['id']),
        salesId: castToType<int>(data['sales_id']),
        salesName: data['sales_name'] as String?,
        status: data['status'] as String?,
        title: data['title'] as String?,
        updatedAt: data['updated_at'] as String?,
      );

  static TasksStruct? maybeFromMap(dynamic data) =>
      data is Map ? TasksStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'body': _body,
        'created_at': _createdAt,
        'id': _id,
        'sales_id': _salesId,
        'sales_name': _salesName,
        'status': _status,
        'title': _title,
        'updated_at': _updatedAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'body': serializeParam(
          _body,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'sales_id': serializeParam(
          _salesId,
          ParamType.int,
        ),
        'sales_name': serializeParam(
          _salesName,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'updated_at': serializeParam(
          _updatedAt,
          ParamType.String,
        ),
      }.withoutNulls;

  static TasksStruct fromSerializableMap(Map<String, dynamic> data) =>
      TasksStruct(
        body: deserializeParam(
          data['body'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        salesId: deserializeParam(
          data['sales_id'],
          ParamType.int,
          false,
        ),
        salesName: deserializeParam(
          data['sales_name'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
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
  String toString() => 'TasksStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TasksStruct &&
        body == other.body &&
        createdAt == other.createdAt &&
        id == other.id &&
        salesId == other.salesId &&
        salesName == other.salesName &&
        status == other.status &&
        title == other.title &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [body, createdAt, id, salesId, salesName, status, title, updatedAt]);
}

TasksStruct createTasksStruct({
  String? body,
  String? createdAt,
  int? id,
  int? salesId,
  String? salesName,
  String? status,
  String? title,
  String? updatedAt,
}) =>
    TasksStruct(
      body: body,
      createdAt: createdAt,
      id: id,
      salesId: salesId,
      salesName: salesName,
      status: status,
      title: title,
      updatedAt: updatedAt,
    );
