import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogame_api/config/router/app_router.dart';
import 'package:videogame_api/config/theme/app_theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getAppTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
