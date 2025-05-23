import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tg_app/connect.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return; // L'utilisateur a annulé la connexion

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Afficher un message de succès
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connexion réussie !")),
      );
    } catch (e) {
      // Afficher l'erreur à l'utilisateur
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur: $e")),
      );
    }
  }

  final TextEditingController nameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpWithEmail() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Mise à jour du profil avec le nom
      await userCredential.user?.updateDisplayName(nameController.text.trim());

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Compte créé avec succès !")),
      );

      // Rediriger vers la page d'accueil ou de connexion
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => Connect()),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: ListView(
          children: [
            SizedBox(height: 30.h),
            Center(
              child: Text(
                'Créer un compte',
                style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1),
              ),
            ),
            Center(
              child: Text(
                "Pour pouvoir utiliser l'application et avoir accès à toutes ses fonctionnalités, vous devez vous inscrire !",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50.h),
            Text(
              'Nom et prénom',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[150],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
              cursorColor: Color(0xff3c5a5d),
            ),
            SizedBox(height: 20.h),
            Text(
              'Email',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[150], // Arrière-plan
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none, // Supprime la bordure de base
                ),
              ),
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
              cursorColor: Color(0xff3c5a5d),
            ),
            SizedBox(height: 20.h),
            Text(
              'Mot de passe',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: passwordController,
              obscureText: obscureText,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[150], // Arrière-plan
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none, // Supprime la bordure de base
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText; // Changer l'état
                    });
                  },
                ),
              ),
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
              cursorColor: Color(0xff3c5a5d),
            ),
            SizedBox(height: 20.h),
            /*Center(
                child: ElevatedButton(
                    onPressed: () {
                      signUpWithEmail();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff000216),
                      padding: EdgeInsets.symmetric(
                          horizontal: 141.w, vertical: 15.h),
                    ),
                    child: Center(
                      child: Text(
                        "Créer un compte",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ))),*/
            InkWell(
              onTap: () {
                signUpWithEmail();
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff000216),
                    borderRadius: BorderRadius.circular(21.r)),
                child: Center(
                  child: Text(
                    'Créer un compte',
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Ou se connecter avec",
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.w,
                        )),
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      child: Image.asset(
                        'assets/img/apple.png',
                        width: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  InkWell(
                    onTap: signInWithGoogle,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          )),
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        child: Image.asset(
                          'assets/img/google.png',
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      child: Image.asset(
                        'assets/img/facebook.png',
                        width: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Color(0xff3c5a5d),
                  ),
                  children: [
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: ' ',
                    ),
                    WidgetSpan(
                      child: InkWell(
                        onTap: () {
                          // Redirection vers la page de connexion
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Connect()),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xff3c5a5d),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
