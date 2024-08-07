// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TaskEntityStruct extends BaseStruct {
  TaskEntityStruct({
    int? totalPending,
    int? totalSuccess,
    List<TasksStruct>? tasks,
  })  : _totalPending = totalPending,
        _totalSuccess = totalSuccess,
        _tasks = tasks;

  // "total_pending" field.
  int? _totalPending;
  int get totalPending => _totalPending ?? 0;
  set totalPending(int? val) => _totalPending = val;

  void incrementTotalPending(int amount) =>
      totalPending = totalPending + amount;

  bool hasTotalPending() => _totalPending != null;

  // "total_success" field.
  int? _totalSuccess;
  int get totalSuccess => _totalSuccess ?? 0;
  set totalSuccess(int? val) => _totalSuccess = val;

  void incrementTotalSuccess(int amount) =>
      totalSuccess = totalSuccess + amount;

  bool hasTotalSuccess() => _totalSuccess != null;

  // "tasks" field.
  List<TasksStruct>? _tasks;
  List<TasksStruct> get tasks => _tasks ?? const [];
  set tasks(List<TasksStruct>? val) => _tasks = val;

  void updateTasks(Function(List<TasksStruct>) updateFn) {
    updateFn(_tasks ??= []);
  }

  bool hasTasks() => _tasks != null;

  static TaskEntityStruct fromMap(Map<String, dynamic> data) =>
      TaskEntityStruct(
        totalPending: castToType<int>(data['total_pending']),
        totalSuccess: castToType<int>(data['total_success']),
        tasks: getStructList(
          data['tasks'],
          TasksStruct.fromMap,
        ),
      );

  static TaskEntityStruct? maybeFromMap(dynamic data) => data is Map
      ? TaskEntityStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'total_pending': _totalPending,
        'total_success': _totalSuccess,
        'tasks': _tasks?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'total_pending': serializeParam(
          _totalPending,
          ParamType.int,
        ),
        'total_success': serializeParam(
          _totalSuccess,
          ParamType.int,
        ),
        'tasks': serializeParam(
          _tasks,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static TaskEntityStruct fromSerializableMap(Map<String, dynamic> data) =>
      TaskEntityStruct(
        totalPending: deserializeParam(
          data['total_pending'],
          ParamType.int,
          false,
        ),
        totalSuccess: deserializeParam(
          data['total_success'],
          ParamType.int,
          false,
        ),
        tasks: deserializeStructParam<TasksStruct>(
          data['tasks'],
          ParamType.DataStruct,
          true,
          structBuilder: TasksStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'TaskEntityStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TaskEntityStruct &&
        totalPending == other.totalPending &&
        totalSuccess == other.totalSuccess &&
        listEquality.equals(tasks, other.tasks);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([totalPending, totalSuccess, tasks]);
}

TaskEntityStruct createTaskEntityStruct({
  int? totalPending,
  int? totalSuccess,
}) =>
    TaskEntityStruct(
      totalPending: totalPending,
      totalSuccess: totalSuccess,
    );
