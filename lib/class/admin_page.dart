import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  Future<void> ajouterCategorieEtVideos() async {
  final firestore = FirebaseFirestore.instance;

  // Vérifie si la catégorie existe déjà
  final querySnapshot = await firestore
      .collection('categories')
      .where('name', isEqualTo: 'Cultes du dimanche')
      .get();

  DocumentReference categorieRef;

  if (querySnapshot.docs.isNotEmpty) {
    categorieRef = querySnapshot.docs.first.reference;
  } else {
    final newCat = await firestore.collection('categories').add({
      'name': 'Cultes du dimanche',
    });
    categorieRef = newCat;
  }

  final videos = [
    {
      'title': 'Culte',
      'theme': 'LA SOIF DE DIEU',
      'image': 'https://i.ytimg.com/vi/p7ecMQWwQkc/hqdefault.jpg',
      'image_orateur':
          'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436188.jpg',
      'url': 'https://www.youtube.com/watch?v=p7ecMQWwQkc',
      'date': '14/07',
      'orateur': 'Pasteur Pascal',
      'resume':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum nec odio.',
    },
  ];

  for (var video in videos) {
    final existing = await categorieRef
        .collection('videos')
        .where('url', isEqualTo: video['url'])
        .get();

    if (existing.docs.isEmpty) {
      await categorieRef.collection('videos').add(video);
      print("✅ Vidéo ajoutée : ${video['theme']}");
    } else {
      print("⚠️ Vidéo déjà existante : ${video['theme']}");
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Espace Admin")),
      body: Center(
        child: ElevatedButton(
          onPressed: ajouterCategorieEtVideos,
          child: Text("Ajouter les vidéos"),
        ),
      ),
    );
  }
}
