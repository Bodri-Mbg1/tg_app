
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

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
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "heure": "18H"
    },
    {
      "title": "Reunion d’enseignement",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "heure": "18H"
    },
    {
      "title": "Reunion de jeunesse",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "heure": "14H"
    },
    {
      "title": "Culte d’adoration",
      "description": "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "heure": "09H"
    },
  ];
  @override
  void initState() {
    AwesomeNotifications().requestPermissionToSendNotifications();
    super.initState();
  }

  triggerNotification() async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: "Reunion de prière",
        body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        notificationLayout: NotificationLayout.BigPicture,
      )
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
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: Colors.black)),
              const SizedBox(height: 20),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      left: 18,
                      top: 0,
                      bottom: 0,
                      child: Container(width: 2, color: violet),
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
                                    decoration: BoxDecoration(color: orange, shape: BoxShape.circle),
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    const SizedBox(height: 4),
                                    Text(item['description']!, style: const TextStyle(fontSize: 13)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                                decoration: BoxDecoration(color: orange, borderRadius: BorderRadius.circular(12)),
                                child: Text(item['heure']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  icon: const Icon(Icons.notifications_none, color: Colors.white),
                  label: const Text('Activer un rappel', style: TextStyle(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
    final List<String> jours = ['Mardi', 'Jeudi', 'Samedi', 'Vendredi', 'Dimanche'];

    final Map<String, bool> selection = {for (var jour in jours) jour: false};

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
                  onPressed: () {
                    
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
}