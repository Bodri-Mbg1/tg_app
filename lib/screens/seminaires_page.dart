import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tg_app/screens/detail_video_page.dart';

class SeminairesPage extends StatelessWidget {
  const SeminairesPage({super.key});

  Stream<List<Map<String, dynamic>>> recupererSeminaires() {
    return FirebaseFirestore.instance
        .collection('categories')
        .where('name', isEqualTo: 'Séminaires')
        .limit(1)
        .snapshots()
        .asyncMap((snapshot) async {
      if (snapshot.docs.isEmpty) return [];
      final ref = snapshot.docs.first.reference;
      final videosSnap = await ref.collection('videos').get();
      // ignore: unnecessary_cast
      return videosSnap.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cultes du dimanche"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: recupererSeminaires(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return const Center(child: CircularProgressIndicator());
            final videos = snapshot.data!;
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailVideoPage(video: video)),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white,
                        border:
                            Border.all(color: Color(0xffd8d8d8), width: 0.5),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(video['title'],
                                    style: TextStyle(fontSize: 14.sp)),
                                SizedBox(height: 5.h),
                                Text(
                                  video['theme'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 6.h),
                                      decoration: BoxDecoration(
                                        color: Colors.orange[100],
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Text('DIM. ${video['date']}',
                                          style: TextStyle(fontSize: 11.sp)),
                                    ),
                                    SizedBox(width: 6.w),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 6.h),
                                      decoration: BoxDecoration(
                                        color: Colors.brown[100],
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Text(video['orateur'],
                                          style: TextStyle(fontSize: 11.sp)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
