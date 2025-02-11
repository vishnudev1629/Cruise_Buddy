import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleTest extends StatefulWidget {
  const GoogleTest({super.key});

  @override
  _GoogleTestState createState() => _GoogleTestState();
}

class _GoogleTestState extends State<GoogleTest> {
  String? userEmail;

  // Google Sign-In Function
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User canceled sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        setState(() {
          userEmail = user.email;
        });
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
    }
  }

  // Sign-Out Function
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      userEmail = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Login")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (userEmail != null)
                Column(
                  children: [
                    Text("Logged in as: $userEmail"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: signOut,
                      child: const Text("Sign Out"),
                    ),
                  ],
                )
              else
                ElevatedButton(
                  onPressed: signInWithGoogle,
                  child: const Text("Sign in with Google"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
