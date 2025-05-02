import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailVideoPage extends StatelessWidget {
  final Map<String, dynamic> video;

  const DetailVideoPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(video['theme'])),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    video['image'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.play_circle, size: 60, color: Colors.white),
                  onPressed: () async {
                    final url = Uri.parse(video['url']);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                )
              ],
            ),
            SizedBox(height: 10),
            Text("NB : En cliquant vous serez redirigé vers YouTube", style: TextStyle(color: Colors.blue)),
            SizedBox(height: 20),

            Row(
              children: [
                Text("Culte", style: TextStyle(fontSize: 14)),
                Spacer(),
                Icon(Icons.favorite_border)
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('DIM. ${video['date']}'),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.brown[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(video['orateur']),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("LA SOIF DE DIEU", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Résumé", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 8),
            Text(video['resume'] ?? "Aucun résumé disponible."),
          ],
        ),
      ),
    );
  }
}
