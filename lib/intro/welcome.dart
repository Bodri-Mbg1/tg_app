// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tg_app/intro/intro1.dart';
import 'package:tg_app/screens/home_page.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    await Future.delayed(
        const Duration(seconds: 3)); // Simule un écran de chargement

    if (isFirstLaunch) {
      // Met à jour la valeur pour éviter de re-afficher l'intro
      await prefs.setBool('isFirstLaunch', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Intro1()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage2()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff036af7),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff001455),
                Color(0xff000216)
              ], // Couleurs du dégradé
              begin: Alignment.topLeft, // Début du dégradé
              end: Alignment.bottomRight, // Fin du dégradé
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 150.h),
              Center(
                child: Image.asset('assets/img/LOGO TG APP blanc.png'),
              ),
              Center(
                child: LoadingAnimationWidget.twoRotatingArc(
                  color: Color(0xffF5A300),
                  size: 40,
                ),
              ),
              SizedBox(height: 200.h),
              Center(
                child: Text(
                  'Produted by Bodri Mbg',
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              )
            ],
          ),
        ));
  }
}
