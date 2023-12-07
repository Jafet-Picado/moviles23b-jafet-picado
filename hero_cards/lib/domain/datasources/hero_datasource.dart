import 'package:hero_cards/domain/entities/hero_info_detailed.dart';
import 'package:hero_cards/domain/entities/hero_info_minimal.dart';

// Interfaz abstracta para la fuente de datos de héroes
abstract class HeroDatasource {
  // Obtener información detallada de un héroe por su ID
  Future<HeroInfoDetailed> getHeroDetailed({required int id});
  // Obtener información mínima de un héroe aleatorio
  Future<HeroInfoMinimal> getRandomHero();
  // Obtener información mínima de un héroe por su ID
  Future<HeroInfoMinimal> getHeroMinimal({required int id});
}
