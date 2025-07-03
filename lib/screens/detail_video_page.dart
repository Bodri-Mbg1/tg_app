import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Fonction globale pour récupérer les vidéos
Stream<List<Map<String, dynamic>>> recupererToutesLesVideos() {
  final firestore = FirebaseFirestore.instance;
  return firestore.collectionGroup('videos').snapshots().map((snapshot) {
    // ignore: unnecessary_cast
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  });
}

void ouvrirLienVideo(String url) async {
  final uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  } else {
    if (Platform.isAndroid) {
      // 🔥 Fallback Android : ouvrir via Intent brut
      final intent = AndroidIntent(
        action: 'action_view',
        data: url,
      );
      await intent.launch();
    } else {
      // iOS ou autre : message d'erreur
      print("❌ Impossible d’ouvrir le lien.");
    }
  }
}

class DetailVideoPage extends StatelessWidget {
  final Map<String, dynamic> video;

  const DetailVideoPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  child: Image.network(
                    video['image'],
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.play_circle,
                        size: 60.sp, color: Colors.white),
                    onPressed: () {
                      ouvrirLienVideo(video['url']);
                    })
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xff514eb6)),
              child: Center(
                child: Text(
                  "NB : En cliquant vous serez redirigé vers YouTube",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      letterSpacing: -0.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text('DIM. ${video['date']}'),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.brown[100],
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(video['orateur']),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: const Color(0xffd8d8d8),
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 25.sp,
                          icon: const Icon(IconsaxPlusBold.heart,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(video['theme'],
                        style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.bold,
                            height: 1)),
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Résumé",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 8.h),
                  Text(video['resume'] ?? "Aucun résumé disponible."),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Autres vidéos",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 12.h),
                  StreamBuilder<List<Map<String, dynamic>>>(
                    stream: recupererToutesLesVideos(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return const CircularProgressIndicator();
                      final videos = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: videos.map((autreVideo) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailVideoPage(
                                        video:
                                            autreVideo), // ici on passe autreVideo
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 12.w),
                                padding: EdgeInsets.all(12),
                                height: 190.h,
                                width: 320.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                      color: const Color(0xffd8d8d8),
                                      width: 0.5),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(autreVideo['title'],
                                                  style: TextStyle(
                                                      fontSize: 14.sp)),
                                              SizedBox(height: 5.h),
                                              Text(
                                                autreVideo['theme'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 22.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 12.h),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w,
                                                            vertical: 6.h),
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange[100],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r),
                                                    ),
                                                    child: Text(
                                                        'DIM. ${autreVideo['date']}',
                                                        style: TextStyle(
                                                            fontSize: 11.sp)),
                                                  ),
                                                  SizedBox(width: 6.w),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w,
                                                            vertical: 6.h),
                                                    decoration: BoxDecoration(
                                                      color: Colors.brown[100],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r),
                                                    ),
                                                    child: Text(
                                                        autreVideo['orateur'],
                                                        style: TextStyle(
                                                            fontSize: 11.sp)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          child: Image.network(
                                            autreVideo['image_orateur'],
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            decoration: BoxDecoration(
                                              color: const Color(0xffd8d8d8),
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                    IconsaxPlusBold
                                                        .video_circle,
                                                    color: Colors.black),
                                                SizedBox(width: 6.w),
                                                Text('Regarder',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        CircleAvatar(
                                          radius: 25.r,
                                          backgroundColor:
                                              const Color(0xffd8d8d8),
                                          child: const Icon(
                                              IconsaxPlusBold.heart,
                                              color: Colors.black),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
