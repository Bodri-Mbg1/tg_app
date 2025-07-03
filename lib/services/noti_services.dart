import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ignore: library_prefixes
import 'package:timezone/data/latest_all.dart' as tzData;
import 'package:timezone/timezone.dart' as tz;
import 'package:tg_app/services/exact_alarm_helper.dart';

class NotiServices {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  /// Initialisation des notifications + fuseaux horaires
  Future<void> initNotification() async {
    if (_isInitialized) return;

    // 🕐 Initialiser les fuseaux horaires
    tzData.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Libreville'));

    // 📱 Paramètres Android/iOS
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await notificationsPlugin.initialize(settings);
    _isInitialized = true;
  }

  /// Détails de notification
  NotificationDetails notidicationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'weekly_channel',
        'Notifications Hebdomadaires',
        channelDescription: 'Notification chaque semaine à heure fixe',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  /// Notification hebdomadaire
  Future<void> scheduleWeeklyNotification({
    required int id,
    required String title,
    required String body,
    required int weekday,
    required int hour,
    required int minute,
  }) async {
    final hasPermission = await ExactAlarmHelper.hasExactAlarmPermission();

    if (!hasPermission) {
      // ignore: avoid_print
      print(
          "❌ Permission 'Exact Alarms' refusée. Notification ID=$id ignorée.");
      return;
    }

    final now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Avance jusqu’au bon jour de la semaine et une heure future
    while (scheduledDate.weekday != weekday || scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    // ignore: avoid_print
    print("📆 Notification ID=$id planifiée pour : $scheduledDate");

    try {
      await notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        notidicationDetails(),
        // ignore: deprecated_member_use
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    } catch (e) {
      // ignore: avoid_print
      print("❌ Erreur lors de la planification de la notification ID=$id : $e");
    }
  }

  /// Planifier 4 notifications hebdomadaires
  Future<void> planifier4Notifications() async {
    await scheduleWeeklyNotification(
      id: 1,
      title: 'Lundi - 09h',
      body: 'Ceci est la notification du lundi à 9h',
      weekday: DateTime.monday,
      hour: 9,
      minute: 0,
    );
    // ignore: avoid_print
    print("✅ Notification Lundi 9h planifiée");

    await scheduleWeeklyNotification(
      id: 2,
      title: 'Mardi - 12h40',
      body: 'Ceci est la notification du mardi à 14h30',
      weekday: DateTime.tuesday,
      hour: 13,
      minute: 25,
    );

    await scheduleWeeklyNotification(
      id: 3,
      title: 'Mercredi - 18h45',
      body: 'Notification du mercredi à 18h45',
      weekday: DateTime.wednesday,
      hour: 18,
      minute: 45,
    );

    await scheduleWeeklyNotification(
      id: 4,
      title: 'Jeudi - 7h15',
      body: 'Notification du jeudi matin à 7h15',
      weekday: DateTime.thursday,
      hour: 13,
      minute: 10,
    );

    await scheduleWeeklyNotification(
      id: 4,
      title: 'Jeudi - 7h15',
      body: 'Notification du jeudi matin à 7h15',
      weekday: DateTime.friday,
      hour: 13,
      minute: 10,
    );
  }
}
