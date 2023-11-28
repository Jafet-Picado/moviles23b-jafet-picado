import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_cards/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:hero_cards/presentation/widgets.dart';

class BigHeroCardScreen extends StatelessWidget {
  const BigHeroCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icons.arrow_back_rounded,
        ),
        title: const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            'Carta aleatoria',
            style: TextStyle(
              fontFamily: 'Horizon',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          CustomPillButton(
            balance: context.watch<AuthCubit>().state.balance.toString(),
            onTap: () {
              context.push('/balance_store');
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: BigHeroCard(),
          ),
        ),
      ),
    );
  }
}
