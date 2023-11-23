import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<void> createUserData(
      String collectionPath, String email, String username, String bio) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(email).set({
      'username': username,
      'bio': bio,
    });
  }

  Future<void> updateUserData(
      String collectionPath, String email, String field, String data) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(email)
        .update({field: data});
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
      String collectionPath, String email) async {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(email)
        .get();
  }

  void clear() async {
    await FirebaseFirestore.instance.terminate();
    await FirebaseFirestore.instance.clearPersistence();
  }
}
