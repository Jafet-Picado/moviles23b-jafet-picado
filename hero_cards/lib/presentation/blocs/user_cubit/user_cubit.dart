import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero_cards/infrastructure/services/firestore_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  Future<void> getUsers() async {
    emit(state.copyWith(isLoading: true));
    final querySnapshot = await FirestoreService().getUsers();
    List<Map<String, dynamic>> users =
        querySnapshot.docs.map((QueryDocumentSnapshot documentSnapshot) {
      String username = documentSnapshot['username'];
      String bio = documentSnapshot['bio'];
      int balance = documentSnapshot['balance'];
      bool isOnline = documentSnapshot['isOnline'];
      List<dynamic> cards = documentSnapshot['cards'];
      final map = <String, dynamic>{
        'username': username,
        'bio': bio,
        'balance': balance,
        'isOnline': isOnline,
        'cards': cards,
      };
      return map;
    }).toList();
    emit(state.copyWith(isLoading: false, users: users));
  }
}
