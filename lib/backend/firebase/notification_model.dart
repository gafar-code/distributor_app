class NotificationMessageModel {
  final String? type;
  final NotificationData? data;

  NotificationMessageModel({this.type, this.data});

  // Factory constructor to create a NotificationMessageModel from a JSON map
  factory NotificationMessageModel.fromJson(Map<String, dynamic> json) {
    return NotificationMessageModel(
      type: json['type'],
      data:
          json['data'] != null ? NotificationData.fromJson(json['data']) : null,
    );
  }

  // Method to convert NotificationMessageModel to JSON map
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'data': data?.toJson(),
    };
  }
}

class NotificationData {
  final int? id;
  final String? title;
  final String? description;

  NotificationData({this.id, this.title, this.description});

  // Factory constructor to create NotificationData from a JSON map
  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  // Method to convert NotificationData to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
