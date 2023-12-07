import 'package:hero_cards/domain/datasources/hero_datasource.dart';
import 'package:hero_cards/domain/entities/hero_info_detailed.dart';
import 'package:hero_cards/domain/entities/hero_info_minimal.dart';
import 'package:hero_cards/domain/repositories/hero_repository.dart';

//Implementación de la clase abstracta del repositorio de héroes
class HeroRepositoryImpl extends HeroRepository {
  final HeroDatasource datasource;

  HeroRepositoryImpl({required this.datasource});

  //Obtiene la información detallada de un héroe con su ID al llamar al método
  //correspondiente en la clase de fuente de datos.
  @override
  Future<HeroInfoDetailed> getHeroDetailed({required int id}) {
    return datasource.getHeroDetailed(id: id);
  }

  //Obtiene la información mínima de un héroe aleatorio al llamar al método
  //correspondiente en la clase de fuente de datos.
  @override
  Future<HeroInfoMinimal> getRandomHero() {
    return datasource.getRandomHero();
  }

  //Obtiene la información mínima de un héroe con su ID al llamar al método
  //correspondiente en la clase de fuente de datos.
  @override
  Future<HeroInfoMinimal> getHeroMinimal({required int id}) {
    return datasource.getHeroMinimal(id: id);
  }
}
