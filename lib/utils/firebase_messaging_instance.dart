import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseMessagingInstance extends GetxService {
  late FirebaseMessaging _firebaseMessaging;

  Future<FirebaseMessagingInstance> init() async {
    _firebaseMessaging = FirebaseMessaging.instance;
    return this;
  }

  FirebaseMessaging get firebaseMessaging => _firebaseMessaging;
}
