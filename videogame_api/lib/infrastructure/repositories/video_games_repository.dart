import 'package:videogame_api/domain/datasources/video_games_datasource.dart';
import 'package:videogame_api/domain/entities/video_game_info.dart';
import 'package:videogame_api/domain/repositories/video_games_repository.dart';

class VideoGamesRepositoryImpl extends VideoGameReposity {
  final VideoGamesDatasource datasource;

  VideoGamesRepositoryImpl({required this.datasource});

  @override
  Future<List<VideoGameInfo>> getAllVideoGames(
      {int limit = 20, int offset = 0}) async {
    return datasource.getAllVideoGames(limit: limit, offset: offset);
  }
}
