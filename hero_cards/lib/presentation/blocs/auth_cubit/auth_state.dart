part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool isAuth;
  final bool isCreatingAccount;
  final bool isLoading;
  final bool error;
  final String errorMessage;
  final bool useFingerprint;

  final String email;
  final String username;
  final String bio;
  final List<HeroInfo> heroes;

  const AuthState({
    this.isAuth = false,
    this.isCreatingAccount = false,
    this.isLoading = false,
    this.error = false,
    this.errorMessage = '',
    this.useFingerprint = false,
    this.email = '',
    this.username = '',
    this.bio = '',
    this.heroes = const [],
  });

  AuthState copyWith({
    bool? isAuth,
    bool? isCreatingAccount,
    bool? isLoading,
    bool? error,
    String? errorMessage,
    bool? useFingerprint,
    String? email,
    String? username,
    String? bio,
    List<HeroInfo>? heroes,
  }) =>
      AuthState(
        isAuth: isAuth ?? this.isAuth,
        isCreatingAccount: isCreatingAccount ?? this.isCreatingAccount,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage,
        useFingerprint: useFingerprint ?? this.useFingerprint,
        email: email ?? this.email,
        username: username ?? this.username,
        bio: bio ?? this.bio,
        heroes: heroes ?? this.heroes,
      );

  @override
  List<Object> get props => [
        isAuth,
        isCreatingAccount,
        isLoading,
        error,
        errorMessage,
        useFingerprint,
        email,
        username,
        bio,
        heroes,
      ];
}
