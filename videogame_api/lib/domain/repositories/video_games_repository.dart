import 'package:videogame_api/domain/entities/video_game_info.dart';

abstract class VideoGameReposity {
  Future<List<VideoGameInfo>> getAllVideoGames({
    int limit = 20,
    int offset = 0,
  });
}
