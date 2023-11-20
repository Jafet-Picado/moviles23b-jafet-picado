import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogame_api/infrastructure/datasources/moby_video_game_datasource.dart';
import 'package:videogame_api/infrastructure/repositories/video_games_repository.dart';

final videoGameReposityProvider = Provider(
  (ref) => VideoGamesRepositoryImpl(datasource: MobyVideoGameDatasource()),
);
