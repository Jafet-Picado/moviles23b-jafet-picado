import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero_cards/domain/entities/hero_info.dart';
import 'package:hero_cards/domain/entities/hero_info_minimal.dart';
import 'package:hero_cards/infrastructure/datasources/superhero_datasource.dart';
import 'package:hero_cards/infrastructure/repositories/hero_repository.dart';
import 'package:hero_cards/infrastructure/services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Future<void> signInUser(String email, String password) async {
    emit(state.copyWith(isLoading: true));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = FirebaseAuth.instance.currentUser!;
      emit(
        state.copyWith(
          isAuth: true,
          isLoading: false,
          email: user.email,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isAuth: false,
          error: true,
          errorMessage: e.code,
        ),
      );
    }
  }

  Future<void> signUpUser(String email, String password) async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirestoreService().createUserData(
        'users',
        email,
        email.split('@')[0],
        'Biografía vacía...',
      );

      final user = FirebaseAuth.instance.currentUser!;
      final userData = await FirestoreService().getUserData('users', email);

      emit(
        state.copyWith(
          isLoading: false,
          isAuth: true,
          isCreatingAccount: false,
          email: user.email,
          username: userData.data()!['username'],
          bio: userData.data()!['bio'],
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isAuth: false,
          error: true,
          errorMessage: e.code,
        ),
      );
    }
  }

  Future<void> updateUserData(String email, String field, String data) async {
    emit(state.copyWith(isLoading: true));
    try {
      await FirestoreService().updateUserData('users', email, field, data);
      final userData = await FirestoreService().getUserData('users', email);
      emit(
        state.copyWith(
          isLoading: false,
          username: userData.data()!['username'],
          bio: userData.data()!['bio'],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
    FirestoreService().clear();
    emit(const AuthState());
  }

  void isCreatingAccount() {
    emit(
      state.copyWith(
        isCreatingAccount: true,
        error: false,
        errorMessage: '',
      ),
    );
  }

  void reset() {
    emit(const AuthState());
  }

  Future<void> getUserCards() async {
    try {
      emit(state.copyWith(isLoading: true));
      final user = FirebaseAuth.instance.currentUser!;
      final userData =
          await FirestoreService().getUserData('users', user.email!);
      HeroRepositoryImpl repo =
          HeroRepositoryImpl(datasource: SuperheroDatasource());
      List<HeroInfo> heroesList = [];
      for (int id in userData.data()!['cards']) {
        await repo.getHero(id: id).then((value) => heroesList.add(value));
      }

      emit(state.copyWith(
        isLoading: false,
        heroes: heroesList,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: true,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> getHeroesMinimalByList() async {
    try {
      emit(state.copyWith(isLoading: true));
      final user = FirebaseAuth.instance.currentUser!;
      final userData =
          await FirestoreService().getUserData('users', user.email!);
      HeroRepositoryImpl repo =
          HeroRepositoryImpl(datasource: SuperheroDatasource());
      List<HeroInfoMinimal> heroesList = [];
      for (int id in userData.data()!['cards']) {
        await repo
            .getHeroMinimal(id: id)
            .then((value) => heroesList.add(value));
      }

      emit(state.copyWith(
        isLoading: false,
        heroesMinimal: heroesList,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: true,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> increaseBalance({required int increase}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final user = FirebaseAuth.instance.currentUser!;
      final userData =
          await FirestoreService().getUserData('users', user.email!);
      int currenteBalance = userData.data()!['balance'];
      int newBalance = currenteBalance + increase;
      emit(
        state.copyWith(
          isLoading: false,
          balance: newBalance,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        error: true,
        errorMessage: e.toString(),
      ));
    }
  }
}
