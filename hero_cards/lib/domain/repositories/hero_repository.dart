import 'package:hero_cards/domain/entities/hero_info.dart';
import 'package:hero_cards/domain/entities/hero_info_detailed.dart';
import 'package:hero_cards/domain/entities/hero_info_minimal.dart';

abstract class HeroRepository {
  Future<HeroInfo> getHero({required int id});
  Future<HeroInfoDetailed> getHeroDetailed({required int id});
  Future<HeroInfoMinimal> getRandomHero();
  Future<HeroInfoMinimal> getHeroMinimal({required int id});
}
