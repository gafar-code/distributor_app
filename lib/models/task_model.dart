import 'dart:convert';

import 'package:distributor_app/models/login_model.dart';

TaskListModel taskListModelFromJson(String str) =>
    TaskListModel.fromJson(json.decode(str));

TaskWrapperModel taskWrapperModelFromJson(String str) =>
    TaskWrapperModel.fromJson(json.decode(str));

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

class TaskModel {
  final TaskWrapperModel data;

  TaskModel({required this.data});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        data: TaskWrapperModel.fromJson(json["data"]),
      );
}

class TaskWrapperModel {
  final Task data;
  final User user;

  TaskWrapperModel({required this.data, required this.user});

  factory TaskWrapperModel.fromJson(Map<String, dynamic> json) =>
      TaskWrapperModel(
          data: Task.fromJson(json["task"]), user: User.fromJson(json['user']));
}

class TaskListModel {
  final TaskListDatum data;

  TaskListModel({
    required this.data,
  });

  factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
        data: TaskListDatum.fromJson(json["data"]),
      );
}

class TaskListDatum {
  final int totalSuccess;
  final int totalPending;
  final List<Task> tasks;

  TaskListDatum({
    required this.totalSuccess,
    required this.totalPending,
    required this.tasks,
  });

  factory TaskListDatum.fromJson(Map<String, dynamic> json) => TaskListDatum(
        totalSuccess: json["total_success"],
        totalPending: json["total_pending"],
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
      );
}

class Task {
  final int id;
  final String title;
  final String body;
  final String status;
  final int salesId;
  final String salesName;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task({
    required this.id,
    required this.title,
    required this.body,
    required this.status,
    required this.salesId,
    required this.salesName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        status: json["status"],
        salesId: json["sales_id"],
        salesName: json["sales_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "status": status,
        "sales_id": salesId,
        "sales_name": salesName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
