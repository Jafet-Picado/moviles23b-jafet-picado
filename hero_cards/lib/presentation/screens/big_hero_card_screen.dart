import 'package:flutter/material.dart';
import 'package:hero_cards/presentation/widgets.dart';

class BigHeroCardScreen extends StatelessWidget {
  const BigHeroCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: BigHeroCard(),
          ),
        ),
      ),
    );
  }
}
