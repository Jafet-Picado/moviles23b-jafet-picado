part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool isAuth;
  final bool isCreatingAccount;
  final bool isLoading;
  final bool error;
  final String errorMessage;

  final String email;
  final String username;
  final String bio;

  const AuthState({
    this.isAuth = false,
    this.isCreatingAccount = false,
    this.isLoading = false,
    this.error = false,
    this.errorMessage = '',
    this.email = '',
    this.username = '',
    this.bio = '',
  });

  AuthState copyWith({
    bool? isAuth,
    bool? isCreatingAccount,
    bool? isLoading,
    bool? error,
    String? errorMessage,
    String? email,
    String? username,
    String? bio,
  }) =>
      AuthState(
        isAuth: isAuth ?? this.isAuth,
        isCreatingAccount: isCreatingAccount ?? this.isCreatingAccount,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage,
        email: email ?? this.email,
        username: username ?? this.username,
        bio: bio ?? this.bio,
      );

  @override
  List<Object> get props => [
        isAuth,
        isCreatingAccount,
        isLoading,
        error,
        errorMessage,
        email,
        username,
        bio,
      ];
}
