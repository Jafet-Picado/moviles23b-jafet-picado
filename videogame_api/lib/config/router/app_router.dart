import 'package:go_router/go_router.dart';
import 'package:videogame_api/presentation/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
