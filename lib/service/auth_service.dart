import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart'; // Import untuk kIsWeb

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ... (kode lainnya)

  Future<User?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Alur untuk Web menggunakan Popup
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        UserCredential userCredential = await _auth.signInWithPopup(googleProvider);
        return userCredential.user;
      } else {
        // Alur untuk Mobile (Android/iOS)
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) return null;
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signInWithEmailAndPassword(String text, String text2) async {}

  Future registerWithEmailAndPassword(String text, String text2) async {}

  // ... (kode lainnya)
}