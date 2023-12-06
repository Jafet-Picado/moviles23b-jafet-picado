import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_cards/presentation/blocs.dart';
import 'package:hero_cards/presentation/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final isAuth = context.read<AuthCubit>().state.isAuth;
    final isCreatingAccount = context.read<AuthCubit>().state.isCreatingAccount;
    if (!isAuth && !isCreatingAccount) {
      return '/login';
    } else {
      return null;
    }
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/hero/:id',
      builder: (context, state) {
        int id = int.parse(state.pathParameters['id']!);
        return HeroInfoScreen(id: id);
      },
    ),
    GoRoute(
      path: '/balance_store',
      builder: (context, state) => const BalanceStoreScreen(),
    ),
    GoRoute(
      path: '/random_card',
      builder: (context, state) => const BigHeroCardScreen(),
    ),
    GoRoute(
      path: '/profile_edit',
      builder: (context, state) => const ProfileEditScreen(),
    ),
  ],
);
