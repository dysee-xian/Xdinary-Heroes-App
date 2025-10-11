import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Tambahkan import Firestore

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instance Firestore

  // Fungsi untuk masuk (Sign In) dengan Email dan Password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Login Gagal: $e");
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Fungsi untuk registrasi dengan Email dan Password, dan menyimpan data ke Firestore
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // --- Bagian Baru: Simpan data user ke Firestore ---
      User? newUser = userCredential.user;
      if (newUser != null) {
        // Membuat data awal user
        await _firestore.collection('users').doc(newUser.uid).set({
          'uid': newUser.uid,
          'email': newUser.email,
          'name': email.split('@')[0], // Nama awal diambil dari bagian email sebelum '@'
          'bio': 'Hi, I am a new Villain!', // Nilai default
          'profileImage': '', // Kosongkan atau berikan URL default
          'createdAt': Timestamp.now(), // Tambahkan timestamp
        });
      }
      // ---------------------------------------------------

      return newUser;
    } on FirebaseAuthException catch (e) {
      print("Registrasi Gagal: $e");
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Metode signInWithGoogle telah dihapus
}