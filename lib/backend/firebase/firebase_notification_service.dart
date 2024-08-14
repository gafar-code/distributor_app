import 'dart:developer';
import 'dart:io';

import 'package:distributor_app/flutter_flow/flutter_flow_util.dart';
import 'package:distributor_app/utils/prefs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import 'notification_model.dart';

class NotificationService {
  final FirebaseMessaging firebaseMessaging;

  NotificationService({required this.firebaseMessaging});

  void notificationInit() async {
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
    final String? token = await firebaseMessaging.getToken();
    log(token.toString(), name: 'fcm token');
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
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveBackgroundNotificationResponse);
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    log(notificationResponse.payload.toString(),
        name: 'Notification clicked foreground');
    if (notificationResponse.payload != null) {
      final notification = NotificationModel.fromJson(
          jsonDecode(notificationResponse.payload.toString()));
      _navigateToDetailTask(notification: notification);
    }
  }

  void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) async {
    log(notificationResponse.payload.toString(),
        name: 'Notification clicked background');
    if (notificationResponse.payload != null) {
      final notification = NotificationModel.fromJson(
          jsonDecode(notificationResponse.payload.toString()));
      _navigateToDetailTask(notification: notification, isBackground: true);
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
    log(message.data.toString(), name: 'bg remote message');
    if (message.data.isNotEmpty) {
      final notification = message.data['pagelink'];
      _navigateToDetailTask(
          isBackground: true, taskIdFromRemoteMessage: notification);
    }
  }

  void _navigateToDetailTask(
      {NotificationModel? notification,
      bool isBackground = false,
      String? taskIdFromRemoteMessage}) async {
    final prefs = Get.find<PrefsService>().prefs;

    final taskId = notification?.data.pagelink.split('/').last;
    final taskIdBg = taskIdFromRemoteMessage?.split('/').last;
    if (taskId != '') {
      if (isBackground) {
        navigatorKey.currentContext?.go(
            prefs.getString('role') == 'ADMIN' ? '/homeAdmin' : '/homeSales');
        await navigatorKey.currentContext
            ?.push(
          '/detailTaskSales/$taskIdBg',
        )
            .then((_) {
          Get.find<HomeController>().refreshTasks();
        });
      } else {
        await navigatorKey.currentContext
            ?.push(
          '/detailTaskSales/$taskId',
        )
            .then((_) {
          Get.find<HomeController>().refreshTasks();
        });
      }
    }
  }
}
