// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: unused_import
import 'package:tg_app/screens/programme_card.dart';
import 'package:tg_app/services/exact_alarm_helper.dart';
import 'package:tg_app/services/noti_services.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

class Programme extends StatefulWidget {
  const Programme({super.key});

  @override
  State<Programme> createState() => _ProgrammeState();
}

class _ProgrammeState extends State<Programme> {
  final Color orange = Color(0xFFFEC26C);

  final Color violet = Color(0xff514eb6);

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

  void openExactAlarmSettings() {
    final intent = AndroidIntent(
      action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    intent.launch();
  }

  @override
  void initState() {
    AwesomeNotifications().requestPermissionToSendNotifications();
    super.initState();
  }

  void showDaySelectionDialog(BuildContext context) {
    final List<String> jours = [
      'Lundi',
      'Mardi',
      'Mercredi',
      'Jeudi',
      'Vendredi'
    ];
    final Map<String, bool> selection = {for (var jour in jours) jour: false};

    final Map<String, int> jourToWeekday = {
      'Lundi': DateTime.monday,
      'Mardi': DateTime.tuesday,
      'Mercredi': DateTime.wednesday,
      'Jeudi': DateTime.thursday,
      'Vendredi': DateTime.friday,
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
                    final noti = NotiServices();
                    await noti.initNotification();

                    int id = 1;

                    for (final jour in selection.entries) {
                      if (jour.value) {
                        final weekday = jourToWeekday[jour.key]!;

                        await noti.scheduleWeeklyNotification(
                          id: id++,
                          title: 'Rappel - ${jour.key}',
                          body: 'N’oubliez pas votre programme du ${jour.key}',
                          weekday: weekday,
                          hour: 9,
                          minute: 0,
                        );
                      }
                    }
                    Navigator.pop(context); // Ferme la boîte
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Notifications planifiées !')),
                    );
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
              Container(
                height: 120.h,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // Ajoute une ombre si tu veux
                ),
                clipBehavior: Clip.hardEdge, // Pour arrondir l'image aussi
                child: Stack(
                  children: [
                    // Image de fond
                    Image.asset(
                      'assets/img/7246.jpg', // mets ici ton image
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    // Overlay bleu semi-transparent
                    Container(
                      color: const Color(0xFF0D47A1).withOpacity(0.85),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final hasPermission =
                        await ExactAlarmHelper.hasExactAlarmPermission();

                    if (!hasPermission) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '⛔ Permission requise pour programmer des rappels précis.'),
                          action: SnackBarAction(
                            label: 'Activer',
                            onPressed:
                                openExactAlarmSettings, // ← ouvre les paramètres
                          ),
                        ),
                      );
                      return;
                    }

                    showDaySelectionDialog(context);
                  },
                  icon:
                      const Icon(Icons.notifications_none, color: Colors.white),
                  label: const Text('Activer un rappel',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
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
              ElevatedButton(
                onPressed: () async {
                  final noti = NotiServices();
                  await noti.initNotification();

                  final now = DateTime.now();
                  await noti.scheduleWeeklyNotification(
                    id: 999,
                    title: "🔔 Test Notification",
                    body: "Ceci est une notification test dans 1 minute",
                    weekday: now.weekday,
                    hour: now.hour,
                    minute: (now.minute + 1) % 60, // 🔁 dans 1 min
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Notification test dans 1 minute")),
                  );
                },
                child: const Text("Tester Notification Immédiate"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
