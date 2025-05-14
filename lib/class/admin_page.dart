// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  Future<void> ajouterCategorieAvecVideos(String nomCategorie, List<Map<String, dynamic>> videos) async {
    final firestore = FirebaseFirestore.instance;

    // Vérifie si la catégorie existe déjà
    final querySnapshot = await firestore
        .collection('categories')
        .where('name', isEqualTo: nomCategorie)
        .get();

    DocumentReference categorieRef;

    if (querySnapshot.docs.isNotEmpty) {
      categorieRef = querySnapshot.docs.first.reference;
    } else {
      final newCat = await firestore.collection('categories').add({
        'name': nomCategorie,
      });
      categorieRef = newCat;
    }

    for (var video in videos) {
      final existing = await categorieRef
          .collection('videos')
          .where('url', isEqualTo: video['url'])
          .get();

      if (existing.docs.isEmpty) {
        await categorieRef.collection('videos').add(video);
        print("✅ Vidéo ajoutée dans '$nomCategorie' : ${video['theme']}");
      } else {
        print("⚠️ Vidéo déjà existante dans '$nomCategorie' : ${video['theme']}");
      }
    }
  }

  Future<void> ajouterToutesLesCategories() async {
    await ajouterCategorieAvecVideos('Cultes du dimanche', [
      {
        'title': 'Culte',
        'theme': 'LA SOIF DE DIEU',
        'image': 'https://i.ytimg.com/vi/p7ecMQWwQkc/hqdefault.jpg',
        'image_orateur': 'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436188.jpg',
        'url': 'https://www.youtube.com/watch?v=p7ecMQWwQkc',
        'date': '14/07',
        'orateur': 'Pasteur Pascal',
        'resume': 'Lorem ipsum dolor sit amet...',
      },
      {
        'title': 'Culte',
        'theme': 'LA PRÉSENCE DE DIEU',
        'image': 'https://i.ytimg.com/vi/1CNO1O7jJw8/hqdefault.jpg',
        'image_orateur': 'https://img.freepik.com/psd-gratuit/illustration-3d-personne-lunettes-soleil_23-2149436188.jpg',
        'url': 'https://www.youtube.com/watch?v=1CNO1O7jJw8',
        'date': '14/07',
        'orateur': 'Pasteur Pascal',
        'resume': 'Lorem ipsum dolor sit amet...',
      },
    ]);

    await ajouterCategorieAvecVideos('Séminaires', [
      {
        'title': 'Séminaire 1',
        'theme': 'La puissance de la prière',
        'image': 'https://i.ytimg.com/vi/ZkXewxSHND0/hqdefault.jpg',
        'image_orateur': 'https://img.freepik.com/photos-gratuite/homme-confiant-travaillant-comme-medecin-hopital_23-2151204923.jpg',
        'url': 'https://www.youtube.com/watch?v=ZkXewxSHND0',
        'date': '10/06',
        'orateur': 'Prophète Jean',
        'resume': 'Un enseignement profond sur l’intimité avec Dieu...',
      }
    ]);

    await ajouterCategorieAvecVideos('Éditions DUNAMIS', [
      {
        'title': 'Dunamis 2024',
        'theme': 'Feu sur l’autel',
        'image': 'https://i.ytimg.com/vi/NH53khn2rXk/hqdefault.jpg',
        'image_orateur': 'https://img.freepik.com/photos-gratuite/portrait-homme-africain-heureux-souriant_23-2148742956.jpg',
        'url': 'https://www.youtube.com/watch?v=NH53khn2rXk',
        'date': '25/03',
        'orateur': 'Pasteur Grâce',
        'resume': 'Un message puissant sur le zèle spirituel.',
      }
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Espace Admin")),
      body: Center(
        child: ElevatedButton(
          onPressed: ajouterToutesLesCategories,
          child: const Text("Ajouter les vidéos des 3 catégories"),
        ),
      ),
    );
  }
}
