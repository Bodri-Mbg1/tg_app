// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideosItems extends StatefulWidget {
  const VideosItems({super.key});

  @override
  State<VideosItems> createState() => _VideosItemsState();
}

class _VideosItemsState extends State<VideosItems> {
  @override
  void initState() {
    super.initState();

    // Attend 3 secondes, puis appelle la fonction
    Future.delayed(Duration(seconds: 3), () {
      ajouterCategorieEtVideos();
      print('Données sauvegardées automatiquement après 3 secondes');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Sauvegarde automatique en cours..."),
      ),
    );
  }

  Future<void> ajouterCategorieEtVideos() async {
    final firestore = FirebaseFirestore.instance;

    final categorieRef = await firestore.collection('categories').add({
      'name': 'Cultes du dimanche',
    });

    final videos = [
      {
        'title': 'Culte',
        'theme': 'LA SOIF DE DIEU',
        'image': 'https://i.ytimg.com/vi/p7ecMQWwQkc/hqdefault.jpg?sqp=-oaymwEjCNACELwBSFryq4qpAxUIARUAAAAAGAElAADIQj0AgKJDeAE=&rs=AOn4CLAbMOStG7txWrc3cWYYV_bT9Y0C2A',
        'image_orateur': 'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436188.jpg?semt=ais_hybrid&w=740',
        'url': 'https://www.youtube.com/watch?v=p7ecMQWwQkc',
        'date': '14/07',
        'orateur': 'Pasteur Pascal',
      },
    ];

    for (var video in videos) {
      await categorieRef.collection('videos').add(video);
    }

    print('Catégorie et vidéo ajoutées !');
  }
}