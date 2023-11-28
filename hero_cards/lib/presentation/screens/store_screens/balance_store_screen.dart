import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_cards/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:hero_cards/presentation/widgets.dart';

class BalanceStoreScreen extends StatelessWidget {
  const BalanceStoreScreen({super.key});

  void _showDialog(
      ColorScheme colors, BuildContext context, String message, IconData icon) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(
            icon,
            color: colors.onBackground,
            size: 50,
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  void _buyCoins(BuildContext context, AuthCubit authCubit, ColorScheme colors,
      int amount) {
    if ((authCubit.state.balance + amount) > 100000) {
      _showDialog(
        colors,
        context,
        'La cantidad máxima de HeroCoins es de 100.000',
        Icons.warning_rounded,
      );
    } else {
      authCubit.updateBalance(amount: amount);
      _showDialog(
        colors,
        context,
        'Compra exitosa',
        Icons.check_circle_rounded,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final authCubit = context.read<AuthCubit>();

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
              _showDialog(
                colors,
                context,
                'Ya se encuentra en la tienda',
                Icons.warning_rounded,
              );
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Row(
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
            const SizedBox(height: 20),
            BalanceStoreCard(
              image: 'https://img.icons8.com/color/96/batman-old.png',
              title: 'nocturnal',
              amount: '1000',
              price: '2500',
              titleColor: Colors.blueGrey,
              onTap: () {
                _buyCoins(context, authCubit, colors, 1000);
              },
            ),
            BalanceStoreCard(
              image: 'https://img.icons8.com/color/96/superman.png',
              title: 'super',
              amount: '2500',
              price: '6000',
              titleColor: Colors.lightBlue,
              onTap: () {
                _buyCoins(context, authCubit, colors, 2500);
              },
            ),
            BalanceStoreCard(
              image: 'https://img.icons8.com/ios-filled/100/x-men.png',
              title: 'mutant',
              amount: '5000',
              price: '10000',
              iconColor: Colors.yellow,
              titleColor: Colors.yellow,
              onTap: () {
                _buyCoins(context, authCubit, colors, 5000);
              },
            ),
            BalanceStoreCard(
              image: 'https://img.icons8.com/ios/100/000000/spiderman-new.png',
              title: 'spider',
              amount: '10000',
              price: '20000',
              iconColor: Colors.red,
              titleColor: Colors.red,
              onTap: () {
                _buyCoins(context, authCubit, colors, 10000);
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
