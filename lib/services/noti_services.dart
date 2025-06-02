import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiServices {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInstialized = false;

  bool get isInstialized => _isInstialized;

  //INITIALIZE

  Future<void> initNotification() async {
    if (!_isInstialized) return;

    const initSettingsAndroid =
     AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(initSettings);
  }



  NotificationDetails notidicationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        channelDescription: 'channelDescription',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }



  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    await notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails()
    );
  }
}