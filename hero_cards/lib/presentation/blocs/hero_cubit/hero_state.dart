part of 'hero_cubit.dart';

class HeroState extends Equatable {
  final bool isLoading;
  final bool error;
  final String errorMessage;
  final List<HeroInfo> heroes;
  final HeroInfo? hero;

  const HeroState({
    this.isLoading = false,
    this.error = false,
    this.errorMessage = '',
    this.heroes = const [],
    this.hero,
  });

  HeroState copyWith({
    bool? isLoading,
    bool? error,
    String? errorMessage,
    List<HeroInfo>? heroes,
    HeroInfo? hero,
  }) =>
      HeroState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage,
        heroes: heroes ?? this.heroes,
        hero: hero ?? this.hero,
      );

  @override
  List<Object> get props => [
        isLoading,
        error,
        errorMessage,
        heroes,
      ];
}
