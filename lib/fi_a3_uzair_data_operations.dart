import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore data = FirebaseFirestore.instance;

class DataOperations {
  static Future<void> addData(String title, String detail) async {
    data.collection("Notes").add(
      {"title": title, "detail": detail},
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
}
