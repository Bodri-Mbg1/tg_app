import 'package:flutter/material.dart';
import 'package:tg_app/class/admin_page.dart';

class SecretAccessPage extends StatefulWidget {
  const SecretAccessPage({super.key});

  @override
  State<SecretAccessPage> createState() => _SecretAccessPageState();
}

class _SecretAccessPageState extends State<SecretAccessPage> {
  final TextEditingController _controller = TextEditingController();
  final String adminCode = "mbg123"; // Ton mot de passe secret

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Zone réservée")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              obscureText: true,
              decoration: InputDecoration(labelText: "Mot de passe"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text == adminCode) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AdminPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Accès refusé")),
                  );
                }
              },
              child: Text("Entrer"),
            )
          ],
        ),
      ),
    );
  }
}
