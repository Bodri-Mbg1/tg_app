// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tg_app/firebase_options.dart';
import 'package:tg_app/intro/intro1.dart';
import 'package:tg_app/services/noti_permission_helper.dart';
import 'package:tg_app/services/noti_services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final notiServices = NotiServices();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 🔥 Initialisation Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // 🔔 Notification
    await notiServices.initNotification(); // ✅ initialise une seule fois
    if (await hasExactAlarmPermission()) {
      await notiServices.planifier4Notifications();
    } else {
      // ignore: duplicate_ignore
      // ignore: avoid_print
      print('⚠️ Permission EXACT_ALARM refusée. Notifications non planifiées.');
      // 👉 tu peux aussi rediriger vers les paramètres ici
    }

    // 🌍 Date FR
    await initializeDateFormatting('fr_FR', null);

    runApp(const MyApp());
  } catch (e, stack) {
    print('⛔️ Erreur au lancement : $e\n$stack');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Builder(
        // 👈 très important ici
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Walkway'),
            supportedLocales: const [
              Locale('fr', 'FR'),
            ],
            localizationsDelegates: const [
              // ✅ Nécessaire pour les boîtes de dialogue, boutons, etc.
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: const Locale('fr', 'FR'),
            home: const Intro1(),
          );
        },
      ),
    );
  }
}
