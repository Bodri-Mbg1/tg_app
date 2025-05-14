import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tg_app/intro/intro2.dart';

class Intro1 extends StatefulWidget {
  const Intro1({super.key});

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 80.h,
            ),
            Center(
              child: Text("Bienvenue sur Gwatch"),
            ),
            SizedBox(height: 20.h,),
            Center(
              child: Text("La plateforme de visionnage", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 39.sp, height: 0.8),
              textAlign: TextAlign.center,),
            ),
            SizedBox(height: 50.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 180.h,
                      width: 160.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.amber,
                        image: DecorationImage(
                          image: AssetImage("assets/img/LOGO TG APP blanc.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      height: 80.h,
                      width: 160.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.amber,
                        image: DecorationImage(
                          image: AssetImage("assets/img/LOGO TG APP blanc.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.w,),
                Container(
                      height: 270.h,
                      width: 160.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.amber,
                        image: DecorationImage(
                          image: AssetImage("assets/img/LOGO TG APP blanc.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              ],
            ),
            Text(''),
            InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Intro2(),
                        ));
                  },
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff000216),
                      borderRadius: BorderRadius.circular(21.r),
                    ),
                    child: Center(
                      child: Text(
                        'Se connecter',
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      ),
                    ),
                  ),
                ),
        ]),
      )
    );
  }
}
