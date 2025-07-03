import 'package:flutter/material.dart';

class ProgrammeCard extends StatelessWidget {
  final String jour;
  final String titre;
  final String description;
  final String imagePath;
  final Color overlayColor;

  const ProgrammeCard({
    super.key,
    required this.jour,
    required this.titre,
    required this.description,
    required this.imagePath,
    required this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath), // Ton image en assets
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            overlayColor.withOpacity(0.85), // Teinte colorée
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Texte "Chaque Mardi"
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chaque",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    jour,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ),
            // Bouton "Dès 18H30"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "Dès 18H30",
                style: TextStyle(
                  color: Color(0xff514eb6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
