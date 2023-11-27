import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hero_cards/domain/datasources/hero_datasource.dart';
import 'package:hero_cards/domain/entities/hero_info.dart';
import 'package:hero_cards/domain/entities/hero_info_detailed.dart';
import 'package:hero_cards/domain/entities/hero_info_minimal.dart';
import 'package:hero_cards/infrastructure/mappers/hero_info_detailed_mapper.dart';
import 'package:hero_cards/infrastructure/mappers/hero_info_mapper.dart';
import 'package:hero_cards/infrastructure/mappers/hero_info_minimal_mapper.dart';
import 'package:hero_cards/infrastructure/models/superhero_response.dart';

class SuperheroDatasource extends HeroDatasource {
  @override
  Future<HeroInfo> getHero({required int id}) async {
    final dio = Dio(BaseOptions(baseUrl: 'https://superheroapi.com/api'));

    final apiKey = dotenv.env['KEY'];

    final response = await dio.get(
      '/$apiKey/$id',
    );

    final heroResponse = SuperheroResponse.fromJson(response.data);
    final HeroInfo hero = HeroInfoMapper().superheroToEntity(heroResponse);

    return hero;
  }

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
