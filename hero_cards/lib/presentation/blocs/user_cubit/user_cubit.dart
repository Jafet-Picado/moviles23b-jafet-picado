import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero_cards/infrastructure/services/firestore_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  Future<void> getUsers() async {
    emit(state.copyWith(isLoading: true));
    final querySnapshot = await FirestoreService().getUsers('users');
    emit(state.copyWith(isLoading: false, users: querySnapshot.docs));
  }
}
