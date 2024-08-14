import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  final NotificationDatum data;

  NotificationModel({
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        data: NotificationDatum.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class NotificationDatum {
  final String pagelink;

  NotificationDatum({
    required this.pagelink,
  });

  factory NotificationDatum.fromJson(Map<String, dynamic> json) =>
      NotificationDatum(
        pagelink: json["pagelink"],
      );

  Map<String, dynamic> toJson() => {
        "pagelink": pagelink,
      };
}
