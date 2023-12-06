import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hero_cards/config/router/app_router.dart';
import 'package:hero_cards/config/theme/theme.dart';
import 'package:hero_cards/firebase_options.dart';
import 'package:hero_cards/presentation/blocs.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AuthCubit()),
      BlocProvider(create: (context) => HeroCubit()),
      BlocProvider(create: (context) => UserCubit()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getAppTheme(),
      routerConfig: appRouter,
    );
  }
}
