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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Row(
              children: [
                Text('Bienvenue,\nMbolo', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28.sp, height: 0.8),),
                Spacer(),
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: const Color(0xffd9d9d9),
                  child: Icon(IconsaxPlusBold.notification, color: Colors.black,), )
              ],
            ),
            Text('Decouvrer', style: TextStyle(fontSize: 17.sp),),
            Row(
              children: [
                Container(
                  height: 50.h,
                  width: 165.w,
                  decoration: BoxDecoration(
                    color: Color(0xff868ED4),
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Row(
                    
                    children: [
                      Icon(Icons.arrow_right, size: 30, color: Colors.white,),
                      Text('Nos cultes', style: TextStyle(color: Colors.white, fontSize: 18.sp),)
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 50.h,
                  width: 165.w,
                  decoration: BoxDecoration(
                    color: Color(0xff868ED4),
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_right, size: 30, color: Colors.white,),
                      Text('Nos séminaires', style: TextStyle(color: Colors.white, fontSize: 18.sp),)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h,),
            Container(
                  height: 50.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: Color(0xff868ED4),
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_right, size: 35, color: Colors.white,),
                      Text('Nos éditions DUNAMIS', style: TextStyle(color: Colors.white, fontSize: 18.sp),)
                    ],
                  ),
                ),

                Row(children: [
                  Text('Videos', style: TextStyle(fontSize: 20.sp),),
                  Spacer(),
                  TextButton(onPressed: () {}, child: Text('Voir plus'))

                ],),
                Container(
                  height: 200.h,
                  width: 400.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcccccc), width: 0.5),
                    borderRadius: BorderRadius.circular(30.r)
                  ),
                ),
          ],
        ),
      )
    );
  }
}
