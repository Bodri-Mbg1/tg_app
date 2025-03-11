import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tg_app/connect.dart';
import 'package:tg_app/create_account.dart';
import 'package:tg_app/screens/home_page.dart';

class Intro1 extends StatefulWidget {
  const Intro1({super.key});

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Opacity(
                  opacity: 0.5,
                  child: Image.asset('assets/img/Sans titre-2.png')),
              Padding(
                padding: const EdgeInsets.only(top: 310.0),
                child: Center(
                  child: Image.asset(
                    'assets/img/Sans titre-1.png',
                    height: 250.h,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenue sur TG App',
                  style: TextStyle(
                      color: Color(0xff000216),
                      letterSpacing: -0.5,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                    'Nous sommes heureux de vous accompagner dans votre parcours de foi, vous offrir des ressources inspirantes',
                    style: TextStyle(
                      color: Color(0xff000216),
                      letterSpacing: -0.5,
                      fontSize: 17.sp,
                      height: 1,
                    )),
                SizedBox(
                  height: 15.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Connect(),
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
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage2(),
                        ));
                  },
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21.r),
                        border: Border.all(
                          color: Color(0xff000216),
                          width: 2,
                        )),
                    child: Center(
                      child: Text(
                        'Pas maintenant',
                        style: TextStyle(
                            color: Color(0xff000216), fontSize: 20.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
