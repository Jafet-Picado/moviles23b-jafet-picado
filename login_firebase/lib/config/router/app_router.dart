import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_firebase/presentation/blocs.dart';
import 'package:login_firebase/presentation/screens.dart';

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
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
  ],
);
