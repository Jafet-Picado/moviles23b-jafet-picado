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
  final List<HeroInfoMinimal> heroesMinimal;
  final int balance;
  final bool isOnline;

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
    this.heroesMinimal = const [],
    this.balance = -1,
    this.isOnline = false,
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
    List<HeroInfoMinimal>? heroesMinimal,
    int? balance,
    bool? isOnline,
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
        heroesMinimal: heroesMinimal ?? this.heroesMinimal,
        balance: balance ?? this.balance,
        isOnline: isOnline ?? this.isOnline,
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
        heroesMinimal,
        balance,
        isOnline,
      ];
}
