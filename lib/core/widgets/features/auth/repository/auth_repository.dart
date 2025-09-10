import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  AuthRepository({
    FirebaseAuth? fireBaseAuth,
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _firebaseAuth = fireBaseAuth ?? FirebaseAuth.instance,
       _storage = storage ?? FirebaseStorage.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  Future<User?> signUp({
    required String email,
    required String password,
    required String username,
    File? profileImage,
  }) async {
    try {
      final creds = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (creds.user != null) {
        String? imageUrl;
        if (profileImage != null) {
          final ref = _storage
              .ref()
              .child("profile_pics")
              .child("${creds.user!.uid}");

          // Await the upload
          await ref.putFile(profileImage);
          imageUrl = await ref.getDownloadURL();
        }

        await _firestore.collection("users").doc(creds.user!.uid).set({
          "email": email,
          "userName": username,
          "profilePic": imageUrl ?? "",
          "createdAt": FieldValue.serverTimestamp(),
        });
      }
      return creds.user;
    } catch (e) {
      print('Sign up error: $e');
      rethrow;
    }
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final cred = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;

  Future<Map<String, dynamic>?> getUserInfo() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    final doc = await _firestore.collection("users").doc(user.uid).get();
    return doc.data();
  }
}
