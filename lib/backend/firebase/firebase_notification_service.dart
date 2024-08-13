import 'dart:developer';
import 'dart:io';

import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:distributor_app/utils/prefs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'notification_model.dart';

class NotificationService {
  final FirebaseMessaging firebaseMessaging;

  NotificationService({required this.firebaseMessaging});

  void notificationInit() async {
    getFirebaseToken();
    createAndroidNotifChannel();
    firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    onForegroundMessage();

    // Handle background/terminated notification tap
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // Handle notification when the app is completely terminated
    final initialMessage = await firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  Future<String> getFirebaseToken() async {
    await firebaseMessaging.deleteToken();
    final String? token = await firebaseMessaging.getToken();
    return token.toString();
  }

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'distributorapp_important_channel', // id
    'Distributor App High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  void createAndroidNotifChannel() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    log(notificationResponse.payload.toString(), name: 'Notification clicked');
    if (notificationResponse.payload != null) {
      final notification = NotificationMessageModel.fromJson(
          jsonDecode(notificationResponse.payload.toString()));
      _navigateToDetailTask(notification);
    }
  }

  void onForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (Platform.isAndroid) {
        FlutterLocalNotificationsPlugin().show(
            notification.hashCode,
            notification?.title,
            notification?.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: android?.smallIcon,
                    styleInformation: const BigTextStyleInformation(''))),
            payload: jsonEncode(message.toMap()));
      }
    });
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    log('Notification clicked in background/terminated state');
    if (message.data.isNotEmpty) {
      final notification = NotificationMessageModel.fromJson(message.data);
      _navigateToDetailTask(notification);
    }
  }

  void _navigateToDetailTask(NotificationMessageModel notification) {
    final prefs = Get.find<PrefsService>().prefs;
    if (notification.type == "task") {
      final taskId = notification.data?.id;
      if (taskId != null) {
        navigatorKey.currentContext?.go(
            prefs.getString('role') == 'ADMIN' ? '/homeAdmin' : '/homeSales');
        navigatorKey.currentContext?.push(
          '/detailTaskSales/$taskId',
        );
      }
    }
  }
}
