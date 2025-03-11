import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:tg_app/screens/cultes.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 4,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: Row(
                  children: [
                    Text(
                      "Bienvenue",
                      style: TextStyle(fontSize: 32.sp, letterSpacing: -1),
                    ),
                    Spacer(),
                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Color(0xff000216),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Icon(IconsaxPlusBold.notification,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff000216)),
                      borderRadius: BorderRadius.circular(27.r),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 7.w), // Ajoute du padding pour l'esthétique
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: Color(0xff000216),
                          child: Icon(IconsaxPlusLinear.search_normal_1,
                              color: Colors
                                  .white), // Remplacé IconsaxPlusLinear par Icons.search
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          // Permet au TextField de prendre l'espace restant
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder
                                  .none, // Enlève le border du TextField
                              hintText: "Rechercher...",
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 35,
                child: ButtonsTabBar(
                  decoration: BoxDecoration(
                    color: const Color(0xff000216),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: const Color(0xFF422f96),
                      width: 1,
                    ),
                  ),
                  unselectedDecoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    color: Color(0xFF1c1d21),
                  ),
                  buttonMargin: const EdgeInsets.symmetric(horizontal: 10),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 17),
                  tabs: const [
                    Tab(text: 'Cultes'),
                    Tab(text: 'DUNAMIS'),
                    Tab(text: 'Seminaires'),
                    Tab(text: 'Bedromo'),
                  ],
                ),
              ),
              const SizedBox(
                height: 300, // Ajuste cette hauteur selon ton besoin
                child: TabBarView(
                  children: [
                    Cultes(),
                    Center(child: Text('data')),
                    Center(child: Text('data')),
                    Center(child: Text('data')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
