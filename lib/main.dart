import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tg_app/firebase_options.dart';
import 'package:tg_app/intro/intro1.dart';
import 'package:tg_app/services/noti_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Initialisation Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Notification

  NotiServices().initNotification();

  // 🌍 Initialisation du format français
  await initializeDateFormatting('fr_FR', null);


  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Walkway',
          ),
          supportedLocales: const [
            Locale('fr', 'FR'),
          ],
          home: const Intro1(),
        );
      },
    );
  }
}
