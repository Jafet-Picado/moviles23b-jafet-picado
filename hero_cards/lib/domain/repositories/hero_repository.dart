import 'package:hero_cards/domain/entities/hero_info.dart';

abstract class HeroRepository {
  Future<HeroInfo> getHero({required int id});
}
