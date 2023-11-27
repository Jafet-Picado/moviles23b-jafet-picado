import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<void> createUserData(
      String collectionPath, String email, String username, String bio) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(email).set({
      'username': username,
      'bio': bio,
      'cards': [],
      'balance': 1000,
    });
  }

  Future<void> updateUserData(
      String collectionPath, String email, String field, String data) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(email)
        .update({field: data});
  }

  void addUserCard(String collectionPath, String email, int id) {
    DocumentReference reference =
        FirebaseFirestore.instance.collection(collectionPath).doc(email);
    reference.update({
      'cards': FieldValue.arrayUnion([id])
    });
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
