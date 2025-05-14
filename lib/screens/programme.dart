import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:tg_app/main.dart';

class Programme extends StatelessWidget {
  Programme({super.key});

  final Color orange = const Color(0xFFFEC26C);
  final Color violet = const Color(0xff514eb6);

  final List<Map<String, String>> programmes = const [
    {
      "title": "Reunion de prière",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "heure": "18H"
    },
    {
      "title": "Reunion d’enseignement",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "heure": "18H"
    },
    {
      "title": "Reunion de jeunesse",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "heure": "14H"
    },
    {
      "title": "Culte d’adoration",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "heure": "09H"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Programme",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              const SizedBox(height: 20),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      left: 18,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 2,
                        color: violet,
                      ),
                    ),
                    ListView.builder(
                      itemCount: programmes.length,
                      itemBuilder: (context, index) {
                        final item = programmes[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: orange,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['title']!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['description']!,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 14),
                                decoration: BoxDecoration(
                                  color: orange,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  item['heure']!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => showDaySelectionDialog(context),
                  icon:
                      const Icon(Icons.notifications_none, color: Colors.white),
                  label: const Text(
                    'Activer un rappel',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void showDaySelectionDialog(BuildContext context) {
    final List<String> jours = [
      'Lundi',
      'Mardi',
      'Jeudi',
      'Dimanche',
    ];

    final Map<String, bool> selection = {
      for (var jour in jours) jour: false,
    };

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Choisissez vos jours"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: jours.map((jour) {
                  return CheckboxListTile(
                    title: Text(jour),
                    value: selection[jour],
                    onChanged: (value) {
                      setState(() {
                        selection[jour] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Annuler"),
                ),
                ElevatedButton(
  onPressed: () async {
  final bool? granted = await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();

  if (granted != null && granted) {
    Navigator.pop(context);
    scheduleSelectedDays(selection);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("📅 Notifications planifiées")),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("⛔ Notifications non autorisées")),
    );
  }
},

  child: const Text("Valider"),
),

              ],
            );
          },
        );
      },
    );
  }

  void scheduleSelectedDays(Map<String, bool> selectedDays) {
    if (selectedDays['Lundi'] == true) {
      _scheduleNotification(
        id: 1,
        title: "Réunion de Prière",
        body: "Commence ta semaine dans la prière.",
        weekday: DateTime.monday,
        hour: 8,
        minute: 0,
      );
      _scheduleNotification(
        id: 2,
        title: "Réunion de Prière",
        body: "Temps de méditation spirituelle.",
        weekday: DateTime.monday,
        hour: 12,
        minute: 0,
      );
    }
    if (selectedDays['Mardi'] == true) {
      _scheduleNotification(
        id: 3,
        title: "Enseignement du soir",
        body: "Rejoins la réunion d’enseignement.",
        weekday: DateTime.tuesday,
        hour: 18,
        minute: 0,
      );
    }
    if (selectedDays['Jeudi'] == true) {
      _scheduleNotification(
        id: 4,
        title: "Réveil de prière",
        body: "Prépare ton cœur pour le message.",
        weekday: DateTime.thursday,
        hour: 9,
        minute: 0,
      );
    }
    if (selectedDays['Dimanche'] == true) {
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
  }

  void _scheduleNotification({
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
          'hebdo_channel',
          'Notifications Hebdomadaires',
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

  tz.TZDateTime _nextInstanceOfWeekdayTime(int weekday, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    while (scheduled.weekday != weekday || scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }
}

extension on AndroidFlutterLocalNotificationsPlugin? {
  requestPermission() {}
}
