import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hero_cards/domain/datasources/hero_datasource.dart';
import 'package:hero_cards/domain/entities/hero_info.dart';
import 'package:hero_cards/infrastructure/mappers/hero_info_mapper.dart';
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
}
