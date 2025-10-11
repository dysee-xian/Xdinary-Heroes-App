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
   Future<void> updateUserData({
    required String uid,
    String? name,
    String? bio,
    String? profileImage, // Opsional jika nanti ada fitur ganti foto
  }) async {
    Map<String, dynamic> updates = {};
    if (name != null) updates['name'] = name;
    if (bio != null) updates['bio'] = bio;
    if (profileImage != null) updates['profileImage'] = profileImage;
    
    // Hanya lakukan update jika ada perubahan
    if (updates.isNotEmpty) {
      await _firestore.collection('users').doc(uid).update(updates);
    }
  }
}
