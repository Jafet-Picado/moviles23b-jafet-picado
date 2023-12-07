import 'package:hero_cards/domain/entities/hero_info_detailed.dart';
import 'package:hero_cards/domain/entities/hero_info_minimal.dart';

//Clase abstracta de un repositorio para manejar la obtención de información
//de los héroes.
abstract class HeroRepository {
  //Obtener la información detallada de un héroe con su ID
  Future<HeroInfoDetailed> getHeroDetailed({required int id});
  //Obtener información minima de un héroe aleatorio
  Future<HeroInfoMinimal> getRandomHero();
  //Obtener la información mínima de un héroe con su ID
  Future<HeroInfoMinimal> getHeroMinimal({required int id});
}
