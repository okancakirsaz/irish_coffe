import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

//TODO: Make apple configration after create dev account
final class NotificationManager {
  static NotificationManager instance = NotificationManager();
  late final FirebaseMessaging firebaseMsg;
  late final String? fcmToken;

  Future<void> init() async {
    //TODO fix the bug (should be less dependency on build.gradle)
    firebaseMsg = FirebaseMessaging.instance;
    _initToken();
    await _requestPermission();
    firebaseMsg.subscribeToTopic("deneme");
    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification?.title);
    });
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  Future<void> _initToken() async {
    fcmToken = await firebaseMsg.getToken();
    debugPrint(fcmToken);
  }

  _requestPermission() async {
    await firebaseMsg.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
