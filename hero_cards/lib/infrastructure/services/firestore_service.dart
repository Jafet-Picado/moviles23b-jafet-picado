import 'package:cloud_firestore/cloud_firestore.dart';

//Clase encargada de manejar los servicios de almacenamiento y autenticación
//con Firebase
class FirestoreService {
  //Crea la información personal de cada usuario, esto incluye: nombre de usuario,
  //biografía, lista de IDs de sus cartas, cantidad de monedas actuales y su estado
  //en la aplicación (Online/Offline)
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

  //Actualiza un campo especifico de la información de un usuario al modificar
  //el documento donde se almacena dicha información.
  Future<void> updateUserData(
      String collectionPath, String email, String field, dynamic data) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(email)
        .update({field: data});
  }

  //Añade el ID de una carta a la lista de cartas del usuario
  Future<void> addUserCard(String collectionPath, String email, int id) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(email)
        .update({
      'cards': FieldValue.arrayUnion([id])
    });
  }

  //Retorna el documento con la información completa del usuario búscado
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
      String collectionPath, String email) async {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(email)
        .get();
  }

  //Retorna todos los documentos de la colección de usuarios
  Future<QuerySnapshot> getUsers() async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    return await usersCollection.get();
  }

  //Actualiza el monedero del usuario
  Future<void> updateUserBalance(
      String collectionPath, String email, int balance) async {
    await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(email)
        .update({
      'balance': balance,
    });
  }

  //Este método se encarga de terminar la instancia de Firebase utilizada y
  //además elimina los datos persistente de manera local.
  void clear() async {
    await FirebaseFirestore.instance.terminate();
    await FirebaseFirestore.instance.clearPersistence();
  }
}
