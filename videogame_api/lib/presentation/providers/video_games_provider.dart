import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogame_api/domain/entities/video_game_info.dart';
import 'package:videogame_api/presentation/providers/video_games_repository_providers.dart';

final videoGamesProvider =
    StateNotifierProvider<VideoGameNotifier, List<VideoGameInfo>>(
  (ref) {
    final fetchVideoGames =
        ref.watch(videoGameReposityProvider).getAllVideoGames;
    return VideoGameNotifier(fetchVideoGames: fetchVideoGames);
  },
);

typedef VideoGamesCallback = Future<List<VideoGameInfo>> Function(
    {int limit, int offset});

class VideoGameNotifier extends StateNotifier<List<VideoGameInfo>> {
  int limit = 20;
  int offset = 0;
  VideoGamesCallback fetchVideoGames;

  VideoGameNotifier({required this.fetchVideoGames}) : super([]);

  Future<void> loadVideoGamesInfo() async {
    final List<VideoGameInfo> videoGames = await fetchVideoGames(
      limit: limit,
      offset: offset,
    );
    offset = offset + limit;
    state = [...state, ...videoGames];
  }
}
