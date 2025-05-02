
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:tg_app/screens/detail_video_page.dart';


class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  @override

  Stream<List<Map<String, dynamic>>> recupererToutesLesVideos() {
  final firestore = FirebaseFirestore.instance;
  return firestore.collectionGroup('videos').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  });
}

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
  Text('Vidéos', style: TextStyle(fontSize: 20.sp)),
  Spacer(),
  TextButton(onPressed: () {}, child: Text('Voir plus'))
]),
SizedBox(height: 10.h),
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
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.white,
                  border: Border.all(color: Color(0xffd8d8d8), width: 0.5),
                ),
                child: Column(children: [
                  Row(children: [
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${video['title']}', style: TextStyle(fontSize: 14.sp)),
                    SizedBox(height: 5.h),
                    Text(video['theme'], style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 13.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text('DIM. ${video['date']}'),
                        ),
                        SizedBox(width: 2.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(video['orateur']),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    /*Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            video['image'],
                            width: 100,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.play_circle),
                          onPressed: () {
                            // TODO: ouvrir YouTube
                          },
                        ),
                        Spacer(),
                        Icon(Icons.favorite_border),
                      ],
                    )*/
                  ],
                ),
                    Spacer(),
                ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Image.network(
                            video['image_orateur'],
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                  ],),
                  Row(children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Color(0xffd8d8d8),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(IconsaxPlusBold.video_circle, color: Colors.black,),
                          Text('Regarder', style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 25.r,
                      backgroundColor: const Color(0xffd8d8d8),
                      child: IconButton(onPressed: () {}, iconSize: 30, icon: Icon(IconsaxPlusBold.heart, color: Colors.black,),),
                    )
                  ])
                ],)
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
