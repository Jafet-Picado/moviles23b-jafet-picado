part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool isAuth;
  final bool isCreatingAccount;
  final bool isLoading;
  final bool error;
  final String errorMessage;

  final String email;

  const AuthState({
    this.isAuth = false,
    this.isCreatingAccount = false,
    this.isLoading = false,
    this.error = false,
    this.errorMessage = '',
    this.email = '',
  });

  AuthState copyWith({
    bool? isAuth,
    bool? isCreatingAccount,
    bool? isLoading,
    bool? error,
    String? errorMessage,
    String? email,
  }) =>
      AuthState(
        isAuth: isAuth ?? this.isAuth,
        isCreatingAccount: isCreatingAccount ?? this.isCreatingAccount,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage,
        email: email ?? this.email,
      );

  @override
  List<Object> get props =>
      [isAuth, isCreatingAccount, isLoading, error, errorMessage, email];
}
