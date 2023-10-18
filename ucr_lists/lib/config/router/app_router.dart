import 'package:go_router/go_router.dart';
import 'package:ucr_lists/presentation/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
  GoRoute(
      path: '/add-professor',
      builder: (context, state) => const ProfessorAddModifyScreen()),
]);
