import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<void> createUserData(
      String collectionPath, String email, String username, String bio) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(email).set({
      'username': username,
      'bio': bio,
      'cards': [],
      'balance': 1000,
      'isOnline': true,
    });
  }

  Future<void> updateUserData(
      String collectionPath, String email, String field, dynamic data) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(email)
        .update({field: data});
  }

  Future<void> addUserCard(String collectionPath, String email, int id) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(email)
        .update({
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

  Future<QuerySnapshot> getUsers() async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    return await usersCollection.get();
  }

  Future<void> updateUserBalance(
      String collectionPath, String email, int balance) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(email)
        .update({
      'balance': balance,
    });
  }

  void clear() async {
    await FirebaseFirestore.instance.terminate();
    await FirebaseFirestore.instance.clearPersistence();
  }
}
