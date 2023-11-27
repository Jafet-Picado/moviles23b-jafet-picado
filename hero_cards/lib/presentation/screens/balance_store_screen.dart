import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_cards/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:hero_cards/presentation/widgets.dart';

class BalanceStoreScreen extends StatelessWidget {
  const BalanceStoreScreen({super.key});

  void _showWarning(ColorScheme colors, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(
            Icons.warning_rounded,
            color: colors.onBackground,
            size: 50,
          ),
          content: const Text(
            'Ya se encuentra en la tienda',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: CustomElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icons.arrow_back_rounded,
        ),
        actions: [
          CustomPillButton(
            balance: context.watch<AuthCubit>().state.balance.toString(),
            onTap: () {
              _showWarning(colors, context);
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: const Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tienda de HeroCoins',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Horizon',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
