import 'package:firebase_messaging/firebase_messaging.dart';

import '';
Future<void> mensajeBackGround(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');

}

class firebaseNotificationAPI {
    final firebaseMessaging = FirebaseMessaging.instance;
    Future<void> initNotifications() async {
      await firebaseMessaging.requestPermission();
      final fCMToken = await firebaseMessaging.getToken();
      print ('Token $fCMToken' );
      FirebaseMessaging.onBackgroundMessage(mensajeBackGround);
    }
}