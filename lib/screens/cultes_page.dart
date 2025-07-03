import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tg_app/screens/detail_video_page.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';

class CultesPage extends StatefulWidget {
  const CultesPage({super.key});

  @override
  State<CultesPage> createState() => _CultesPageState();
}

class _CultesPageState extends State<CultesPage> with TickerProviderStateMixin {
  late TabController tabController;
  List<String> moisLabels = [];
  Map<String, List<Map<String, dynamic>>> groupedVideos = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    moisLabels = getDerniersMoisLabels();
    chargerVideosEtInitTab();
  }

  List<String> getDerniersMoisLabels() {
    final now = DateTime.now();
    final List<String> mois = [];
    for (int i = 0; i < 6; i++) {
      final date = DateTime(now.year, now.month - i);
      final label = i == 0 ? 'Ce mois' : DateFormat.MMMM('fr_FR').format(date);
      mois.add(label);
    }
    return mois;
  }

  Future<void> chargerVideosEtInitTab() async {
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore
        .collection('categories')
        .where('name', isEqualTo: 'Cultes du dimanche')
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return;

    final ref = snapshot.docs.first.reference;
    final videosSnap = await ref.collection('videos').get();

    final Map<String, List<Map<String, dynamic>>> parMois = {
      for (var label in moisLabels) label: []
    };

    for (var doc in videosSnap.docs) {
      final data = doc.data();
      final dateParts = data['date'].split('/');
      if (dateParts.length == 2) {
        final month = int.tryParse(dateParts[1]);
        final now = DateTime.now();
        final diff = now.month - month!;
        if (diff >= 0 && diff < moisLabels.length) {
          final label = diff == 0
              ? 'Ce mois'
              : DateFormat.MMMM('fr_FR').format(DateTime(now.year, month));
          parMois[label]?.add(data);
        }
      }
    }

    setState(() {
      groupedVideos = parMois;
      tabController = TabController(length: moisLabels.length, vsync: this);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Cultes du dimanche")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cultes du dimanche"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black,
            indicator: BoxDecoration(
              color: Colors.orange[200],
              borderRadius: BorderRadius.circular(50),
            ),
            labelPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
            tabs: moisLabels.map((mois) => Tab(text: mois)).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: moisLabels.map((mois) {
                final videos = groupedVideos[mois] ?? [];
                return ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: videos.length,
                  itemBuilder: (_, index) => buildVideoCard(videos[index]),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVideoCard(Map<String, dynamic> video) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailVideoPage(video: video)),
          );
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
            border: Border.all(color: Color(0xffd8d8d8), width: 0.5),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(video['title'], style: TextStyle(fontSize: 14.sp)),
                        SizedBox(height: 5.h),
                        Text(
                          video['theme'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 22.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: Colors.orange[100],
                                borderRadius: BorderRadius.circular(20.r),
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
                                borderRadius: BorderRadius.circular(20.r),
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
              SizedBox(height: 10.h),
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
                          Icon(IconsaxPlusBold.video_circle,
                              color: Colors.black),
                          SizedBox(width: 6.w),
                          Text('Regarder',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
