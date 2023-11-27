import 'package:hero_cards/domain/datasources/hero_datasource.dart';
import 'package:hero_cards/domain/entities/hero_info.dart';
import 'package:hero_cards/domain/entities/hero_info_detailed.dart';
import 'package:hero_cards/domain/entities/hero_info_minimal.dart';
import 'package:hero_cards/domain/repositories/hero_repository.dart';

class HeroRepositoryImpl extends HeroRepository {
  final HeroDatasource datasource;

  HeroRepositoryImpl({required this.datasource});

  @override
  Future<HeroInfo> getHero({required int id}) async {
    return datasource.getHero(id: id);
  }

  @override
  Future<HeroInfoDetailed> getHeroDetailed({required int id}) {
    return datasource.getHeroDetailed(id: id);
  }

  @override
  Future<HeroInfoMinimal> getRandomHero() {
    return datasource.getRandomHero();
  }

  @override
  Future<HeroInfoMinimal> getHeroMinimal({required int id}) {
    return datasource.getHeroMinimal(id: id);
  }
}
