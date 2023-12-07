import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hero_cards/domain/datasources/hero_datasource.dart';
import 'package:hero_cards/domain/entities/hero_info_detailed.dart';
import 'package:hero_cards/domain/entities/hero_info_minimal.dart';
import 'package:hero_cards/infrastructure/mappers/hero_info_detailed_mapper.dart';
import 'package:hero_cards/infrastructure/mappers/hero_info_minimal_mapper.dart';

//Implementación de la clase abstracta de la fuente de datos de los héroes.
class SuperheroDatasource extends HeroDatasource {
  //Retorna la información detallada de un héroe con su ID, al realizar un
  //llamado al API y posteriormente mapear la respuesta en la clase correspondiente.
  @override
  Future<HeroInfoDetailed> getHeroDetailed({required int id}) async {
    final dio = Dio(BaseOptions(
        baseUrl:
            'https://comicvine.gamespot.com/api/character/4005-$id/?api_key='));

    final apiKey = dotenv.env['API_KEY'];
    final response = await dio.get(
      '$apiKey&format=json',
    );

    final HeroInfoDetailed hero = HeroInfoDetailedMapper()
        .superheroToEntityJSON(response.data['results']);
    return hero;
  }

  //Retorna la información mínima de un héroe aleatorio al obtener un valor
  //entre el 0 y el máximo de información del API y esto lo logra al realizar un
  //llamado al API y posteriormente mapear la respuesta en la clase correspondiente.
  @override
  Future<HeroInfoMinimal> getRandomHero() async {
    int offset = Random().nextInt(158505);

    final apiKey = dotenv.env['API_KEY'];
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://comicvine.gamespot.com/api/characters',
      ),
    );

    final response = await dio.get(
      '/?api_key=$apiKey&format=json&limit=1&offset=$offset',
    );

    final HeroInfoMinimal hero = HeroInfoMinimalMapper()
        .superheroToEntityJSON(response.data['results'][0]);
    return hero;
  }

  //Retorna la información mínima de un héroe con su ID, al realizar un
  //llamado al API y posteriormente mapear la respuesta en la clase correspondiente.
  @override
  Future<HeroInfoMinimal> getHeroMinimal({required int id}) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://comicvine.gamespot.com/api/characters',
      ),
    );

    final apiKey = dotenv.env['API_KEY'];
    final response = await dio.get(
      '/?api_key=$apiKey&format=json&limit=1&filter=id:$id',
    );

    final HeroInfoMinimal hero = HeroInfoMinimalMapper()
        .superheroToEntityJSON(response.data['results'][0]);
    return hero;
  }
}
