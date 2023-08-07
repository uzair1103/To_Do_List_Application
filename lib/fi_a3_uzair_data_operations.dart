import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore data = FirebaseFirestore.instance;

class DataOperations {
  static Future<void> addData(
      String title, String detail, String img_url) async {
    final String? userEmail = FirebaseAuth.instance.currentUser!.email;
    await data.collection("Notes").add(
      {
        "title": title,
        "detail": detail,
        "imageUrl": img_url,
        "Email": userEmail
      },
    ).catchError(
      (e) {},
    );
  }

  static Future<void> delete(String id) async {
    await data.collection('Notes').doc(id).delete();
  }

  static Future<void> updateData(String id, String title, String detail) async {
    await data.collection('Notes').doc(id).update(
      {
        'title': title,
        'detail': detail,
      },
    );
  }

  static Future<void> addUser(String email) async {
    await data.collection("Users").add({"Email": email}).catchError(
      (e) {},
    );
  }
}
