import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:powerpay/util/notificationservice.dart';

class MessagingService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  
  get notificationService => null;
  
  Future<void> disableNotification(String status) async {
    // _fcm.getInitialMessage()
  }

  Future<void> configureMessaging() async {  
    NotificationService notificationService = NotificationService();
    await notificationService.initialize();

    //request system permission
    NotificationSettings settings = await _fcm.requestPermission();
    
        //listening on the background
        FirebaseMessaging.onMessage.listen((message) {
          notificationService.showNotification(message.notification!.title.toString(), message.notification!.body.toString());  
        });
      
        //listening on the background in the surface
        FirebaseMessaging.onMessageOpenedApp.listen((message) {
          notificationService.showNotification(message.notification!.title.toString(), message.notification!.body.toString());  
        }); 


    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      
      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    
      if(initialMessage != null) {
        // Handle message that opened the app from terminated state
        if (kDebugMode) {
          print('Received a message while the app was terminated');
          print('Message data: ${initialMessage.data}');  
        }
        

        if(initialMessage.notification != null) {
          if (kDebugMode) {
            print('Message also contained a notification: ${initialMessage.notification}');
          }

        }
      }
    }

  }
}
