import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:powerpay/util/assetdata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String body) async {
    int id = await _getNextNotificationId();
    
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'Channel Name',
          importance: Importance.max,
          priority: Priority.high,
          groupKey: groupKey,
        ),
        iOS: DarwinNotificationDetails(
          threadIdentifier: groupKey,
        ),
      ),
    );

    await _saveNotification(id, title, body);
    await _showSummaryNotification();
  }

  Future<void> _showSummaryNotification() async {
    List<dynamic> notifications = await _getStoredNotifications();
    
    await flutterLocalNotificationsPlugin.show(
      0, // Use a consistent ID for the summary
      'You have ${notifications.length} notifications',
      'Tap to view',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'you_can_name_it_whatever1',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
          groupKey: groupKey,
          setAsGroupSummary: true,
        ),
        iOS: DarwinNotificationDetails(
          threadIdentifier: groupKey,
        ),
        
      ),
    );
  }

  Future<int> _getNextNotificationId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = (prefs.getInt('last_notification_id') ?? 0) + 1;
    await prefs.setInt('last_notification_id', id);
    return id;
  }

  Future<void> _saveNotification(int id, String title, String body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    notifications.add(jsonEncode({'id': id, 'title': title, 'body': body}));
    await prefs.setStringList('notifications', notifications);
  }

  Future<List<dynamic>> _getStoredNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    return notifications.map((item) => jsonDecode(item)).toList();
  }
}