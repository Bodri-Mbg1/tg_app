import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:tg_app/screens/home_page.dart';
import 'package:tg_app/screens/nav_bar.dart';

class Intro2 extends StatefulWidget {
  const Intro2({super.key});

  @override
  State<Intro2> createState() => _Intro2State();
}

class _Intro2State extends State<Intro2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 150.h,),
          Center(
              child: Text("Sur cette platforme vous pouvez", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 38.sp, height: 0.8),
              textAlign: TextAlign.center,),
            ),
            SizedBox(height: 50.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35.r,
                    backgroundColor: const Color(0xffbcffc0),
                    child: Icon(IconsaxPlusBroken.video_square, size: 30.r, color: Colors.black,),
                  ),
                  SizedBox(width: 8.w),
                  Expanded( // ← Permet au texte de s'adapter à l'espace disponible
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
              'Visionner nos cultes',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20.sp,
                height: 1.2,
              ),
                        ),
                        SizedBox(height: 4.h),
                        Padding(
              padding: const EdgeInsets.only(right: 38.0),  
              child: Text(
                'Sur notre plateforme, le visionnage des vidéos se fait directement via YouTube pour une expérience fluide et sécurisée.',
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35.r,
                    backgroundColor: const Color(0xffffffad),
                    child: Icon(IconsaxPlusBroken.note_1, size: 30.r, color: Colors.black,),
                  ),
                  SizedBox(width: 8.w),
                  Expanded( // ← Permet au texte de s'adapter à l'espace disponible
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
              'Consulter nos programmes',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20.sp,
                height: 1.2,
              ),
                        ),
                        SizedBox(height: 4.h),
                        Padding(
              padding: const EdgeInsets.only(right: 38.0),  
              child: Text(
                'Sur notre plateforme, le visionnage des vidéos se fait directement via YouTube pour une expérience fluide et sécurisée.',
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35.r,
                    backgroundColor: const Color(0xffadcaff),
                    child: Icon(IconsaxPlusBroken.message, size: 30.r, color: Colors.black,),
                  ),
                  SizedBox(width: 8.w),
                  Expanded( // ← Permet au texte de s'adapter à l'espace disponible
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
              'Nos contacter',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20.sp,
                height: 1.2,
              ),
                        ),
                        SizedBox(height: 4.h),
                        Padding(
              padding: const EdgeInsets.only(right: 38.0),  
              child: Text(
                "Consultez le programme de l’église directement depuis notre plateforme, les horaires des cultes et des réunions de prière,des événements spéciaux.",
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavBar(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff514eb6),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Center(
                        child: Text(
                          'Suivant',
                          style: TextStyle(color: Colors.white, fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ),
                ),
            

        ],
      ),
    );
  }
}