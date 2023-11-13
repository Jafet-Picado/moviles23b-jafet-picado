import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<QuerySnapshot<Map<String, dynamic>>> getPosts(
      String collectionPath) async {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy('timestamp', descending: true)
        .get();
  }

  Future<void> addPost(
      String collectionPath, String email, String message) async {
    FirebaseFirestore.instance.collection(collectionPath).add({
      'email': email,
      'message': message,
      'timestamp': Timestamp.now(),
      'likes': []
    });
  }

  void likePost(String collectionPath, String id, bool isLiked, String email) {
    DocumentReference postRef =
        FirebaseFirestore.instance.collection(collectionPath).doc(id);
    if (isLiked) {
      postRef.update({
        'likes': FieldValue.arrayUnion([email])
      });
    } else {
      postRef.update({
        'likes': FieldValue.arrayRemove([email])
      });
    }
  }

  void clear() async {
    await FirebaseFirestore.instance.terminate();
    await FirebaseFirestore.instance.clearPersistence();
  }
}
