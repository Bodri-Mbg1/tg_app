
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:tg_app/screens/cultes_page.dart';
import 'package:tg_app/screens/detail_video_page.dart';
import 'package:tg_app/screens/dunamis_page.dart';
import 'package:tg_app/screens/seminaires_page.dart';


class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  @override

  // ignore: override_on_non_overriding_member
  Stream<List<Map<String, dynamic>>> recupererToutesLesVideos() {
  final firestore = FirebaseFirestore.instance;
  return firestore.collectionGroup('videos').snapshots().map((snapshot) {
    // ignore: unnecessary_cast
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  });
}

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
            SizedBox(height: 10.h,),
            Text('Decouvrer', style: TextStyle(fontSize: 17.sp),),
            SizedBox(height: 10.h,),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CultesPage()),
                    );
                  },
                  child: Container(
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
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SeminairesPage()),
                    );
                  },
                  child: Container(
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
                ),
              ],
            ),
            SizedBox(height: 10.h,),
            GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DunamisPage()),
                    );
                  },
              child: Container(
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
            ),
            SizedBox(height: 10.h,),

                Row(children: [
  Text('Vidéos', style: TextStyle(fontSize: 20.sp)),
  Spacer(),
  TextButton(onPressed: () {}, child: Text('Voir plus'))
]),

StreamBuilder<List<Map<String, dynamic>>>(
    stream: recupererToutesLesVideos(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
      final videos = snapshot.data!;
      return Column(
        children: videos.map((video) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailVideoPage(video: video),
          ),
        );
      },
              child: Container(
  height: 190.h,
  padding: EdgeInsets.all(12),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.r),
    color: Colors.white,
    border: Border.all(color: Color(0xffd8d8d8), width: 0.5),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Partie gauche : titre et thème
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video['title'],
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 5.h),
                Text(
                  video['theme'],
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'DIM. ${video['date']}',
                        style: TextStyle(fontSize: 11.sp),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.brown[100],
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        video['orateur'],
                        style: TextStyle(fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Partie droite fixe : image
          SizedBox(width: 10.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.network(
              video['image_orateur'],
              width: 90.w,
              height: 90.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: Color(0xffd8d8d8),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(IconsaxPlusBold.video_circle, color: Colors.black),
                  SizedBox(width: 6.w),
                  Text(
                    'Regarder',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          CircleAvatar(
            radius: 25.r,
            backgroundColor: const Color(0xffd8d8d8),
            child: Icon(IconsaxPlusBold.heart, color: Colors.black),
          ),
        ],
      ),
    ],
  ),
),

            ),
          );
        }).toList(),
      );
    },
  ),

                
          ],
        ),
      )
    );
  }
}
