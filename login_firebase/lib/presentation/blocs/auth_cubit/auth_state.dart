part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool isAuth;

  const AuthState({
    this.isAuth = false,
  });

  AuthState copyWith({
    bool? isAuth,
  }) =>
      AuthState(
        isAuth: isAuth ?? this.isAuth,
      );

  @override
  List<Object> get props => [isAuth];
}
