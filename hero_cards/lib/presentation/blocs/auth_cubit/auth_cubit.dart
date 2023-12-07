import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero_cards/domain/entities/hero_info_minimal.dart';
import 'package:hero_cards/infrastructure/datasources/superhero_datasource.dart';
import 'package:hero_cards/infrastructure/repositories/hero_repository.dart';
import 'package:hero_cards/infrastructure/services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  //Método utilizado para autenticar al usuario por medio de un correo eléctronico
  //y una contraseña, además, actualiza el estado del usuario para obtener la información
  //del mismo y marcar al usuario con estado Online en la aplicación
  Future<void> signInUser(String email, String password) async {
    emit(state.copyWith(isLoading: true));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = FirebaseAuth.instance.currentUser!;
      final userData =
          await FirestoreService().getUserData('users', user.email!);
      await FirestoreService()
          .updateUserData('users', user.email!, 'isOnline', true);
      emit(
        state.copyWith(
          isAuth: true,
          isLoading: false,
          email: user.email,
          username: userData.data()!['username'],
          bio: userData.data()!['bio'],
          balance: userData.data()!['balance'],
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

  //Registra un usuario nuevo con un correo eléctronico y una contraseña, además,
  //crea la información básica e inicial del usuario.
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
          balance: userData.data()!['balance'],
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

  //Método encargado de actualizar la información de un campo específico de los
  //datos del usuario.
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

  //Cierra la sesión del usuario y actualiza su estado a Offline.
  Future<void> signOutUser() async {
    await FirestoreService().updateUserData(
        'users', FirebaseAuth.instance.currentUser!.email!, 'isOnline', false);
    await FirebaseAuth.instance.signOut();
    FirestoreService().clear();
    emit(const AuthState());
  }

  //Define si un usuario está creando una cuenta para el manejo del router
  void isCreatingAccount() {
    emit(
      state.copyWith(
        isCreatingAccount: true,
        error: false,
        errorMessage: '',
      ),
    );
  }

  //Reinicia el estado
  void reset() {
    emit(const AuthState());
  }

  //Obtiene la información mínima de todos las cartas del usuario autenticado
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

  //Actualiza el monedero del cliente autenticado, ya sea para añadir o reducir
  //su valor
  Future<void> updateBalance({required int amount}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final user = FirebaseAuth.instance.currentUser!;
      final userData =
          await FirestoreService().getUserData('users', user.email!);
      int currenteBalance = userData.data()!['balance'];
      int newBalance = currenteBalance + amount;
      await FirestoreService().updateUserBalance(
        'users',
        user.email!,
        newBalance,
      );
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

  //Añade el ID de una carta a la lista de cartas del usuario autenticado
  Future<void> addCard({required int id}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final user = FirebaseAuth.instance.currentUser!;
      FirestoreService().addUserCard(
        'users',
        user.email!,
        id,
      );
      emit(
        state.copyWith(
          isLoading: false,
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
