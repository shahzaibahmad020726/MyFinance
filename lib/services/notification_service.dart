import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosSettings = DarwinInitializationSettings();
    var settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(settings);
  }

  // Schedule a notification
  Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime scheduledTime,
  ) async {
    var androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.high,
    );
    var iosDetails = DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // Show an immediate notification
  Future<void> showNotification(int id, String title, String body) async {
    var androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.high,
    );
    var iosDetails = DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(id, title, body, notificationDetails);
  }
}
