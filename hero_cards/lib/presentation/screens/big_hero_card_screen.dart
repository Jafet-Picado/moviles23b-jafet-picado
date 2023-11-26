import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hero_cards/presentation/widgets.dart';

class BigHeroCardScreen extends StatelessWidget {
  const BigHeroCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int randomId = 0;
    do {
      randomId = Random().nextInt(732);
    } while (randomId == 482 || randomId == 124);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigHeroCard(
                id: randomId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
