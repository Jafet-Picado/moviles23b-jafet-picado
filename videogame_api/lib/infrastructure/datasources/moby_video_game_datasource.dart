import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:videogame_api/domain/datasources/video_games_datasource.dart';
import 'package:videogame_api/domain/entities/video_game_info.dart';
import 'package:videogame_api/infrastructure/mappers/video_game_info_mapper.dart';
import 'package:videogame_api/infrastructure/models/moby_games/moby_games_response.dart';

class MobyVideoGameDatasource extends VideoGamesDatasource {
  @override
  Future<List<VideoGameInfo>> getAllVideoGames(
      {int limit = 20, int offset = 0}) async {
    final dio = Dio(BaseOptions(baseUrl: 'https://api.mobygames.com/v1'));

    final apiKey = dotenv.env['KEY'];

    final response = await dio.get(
      '/games?api_key=$apiKey&limit=$limit&offset=$offset',
    );

    final mobyResponse = MobyGamesResponse.fromJson(response.data).games;
    final List<VideoGameInfo> games = mobyResponse
        .map((mobyGame) => VideoGameInfoMapper.mobyGametoEntity(mobyGame))
        .toList();

    return games;
  }
}
