import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tg_app/intro/intro2.dart';

class Intro1 extends StatefulWidget {
  const Intro1({super.key});

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  @override@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        SizedBox(height: 80.h),
        Center(child: Text("Bienvenue sur Gwatch")),
        SizedBox(height: 20.h),
        Center(
          child: Text(
            "La plateforme de visionnage",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 39.sp,
                height: 0.8),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 50.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    "assets/img/LOGO TG APP blanc.png",
                    height: 180.h,
                    width: 160.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    "assets/img/LOGO TG APP blanc.png",
                    height: 80.h,
                    width: 160.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                "assets/img/LOGO TG APP blanc.png",
                height: 270.h,
                width: 160.w,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Intro2()),
            );
          },
          child: Container(
            height: 60.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xff000216),
              borderRadius: BorderRadius.circular(21.r),
            ),
            child: Center(
              child: Text(
                'Suivant',
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ]),
    ),
  );
}
}