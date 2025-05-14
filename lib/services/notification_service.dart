import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:tg_app/main.dart'; // Accès à flutterLocalNotificationsPlugin

class NotificationService {
  static void scheduleAllWeeklyNotifications() {
    _scheduleNotification(
      id: 1,
      title: "Réunion de Prière",
      body: "Commence ta semaine dans la prière.",
      weekday: DateTime.tuesday,
      hour: 8,
      minute: 0,
    );

    _scheduleNotification(
      id: 2,
      title: "Réunion de Prière",
      body: "Temps de méditation spirituelle.",
      weekday: DateTime.tuesday,
      hour: 12,
      minute: 0,
    );

    _scheduleNotification(
      id: 3,
      title: "Enseignement du soir",
      body: "Rejoins la réunion d’enseignement.",
      weekday: DateTime.thursday,
      hour: 18,
      minute: 0,
    );

    _scheduleNotification(
      id: 4,
      title: "Réveil de prière",
      body: "Prépare ton cœur pour le message.",
      weekday: DateTime.thursday,
      hour: 9,
      minute: 0,
    );

    _scheduleNotification(
      id: 5,
      title: "Culte dominical",
      body: "Participe au culte avec foi.",
      weekday: DateTime.sunday,
      hour: 10,
      minute: 30,
    );

    _scheduleNotification(
      id: 6,
      title: "Bilan du jour",
      body: "Partage ta réflexion du culte.",
      weekday: DateTime.sunday,
      hour: 18,
      minute: 0,
    );
  }

  static void _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int weekday,
    required int hour,
    required int minute,
  }) {
    final tz.TZDateTime scheduledDate =
        _nextInstanceOfWeekdayTime(weekday, hour, minute);

    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'hebdo_channel', // ID de canal
          'Notifications Hebdomadaires', // Nom du canal
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static tz.TZDateTime _nextInstanceOfWeekdayTime(
      int weekday, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Trouver le prochain jour correct
    while (scheduled.weekday != weekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }
}
