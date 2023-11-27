part of 'hero_cubit.dart';

class HeroState extends Equatable {
  final bool isLoading;
  final bool error;
  final String errorMessage;
  final List<HeroInfo> heroes;
  final HeroInfo? hero;
  final HeroInfoMinimal? heroMinimal;
  final HeroInfoDetailed? heroDetailed;
  final List<HeroInfoMinimal> heroesMinimal;
  final List<HeroInfoDetailed> heroesDetailed;

  const HeroState({
    this.isLoading = false,
    this.error = false,
    this.errorMessage = '',
    this.heroes = const [],
    this.hero,
    this.heroMinimal,
    this.heroDetailed,
    this.heroesMinimal = const [],
    this.heroesDetailed = const [],
  });

  HeroState copyWith({
    bool? isLoading,
    bool? error,
    String? errorMessage,
    List<HeroInfo>? heroes,
    HeroInfo? hero,
    HeroInfoMinimal? heroMinimal,
    HeroInfoDetailed? heroDetailed,
    List<HeroInfoMinimal>? heroesMinimal,
    List<HeroInfoDetailed>? heroesDetailed,
  }) =>
      HeroState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage,
        heroes: heroes ?? this.heroes,
        hero: hero ?? this.hero,
        heroMinimal: heroMinimal ?? this.heroMinimal,
        heroDetailed: heroDetailed ?? this.heroDetailed,
        heroesMinimal: heroesMinimal ?? this.heroesMinimal,
        heroesDetailed: heroesDetailed ?? this.heroesDetailed,
      );

  @override
  List<Object> get props => [
        isLoading,
        error,
        errorMessage,
        heroes,
        heroesMinimal,
        heroesDetailed,
      ];
}
