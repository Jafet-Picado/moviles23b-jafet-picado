import 'package:flutter/material.dart';
import 'package:hero_cards/presentation/widgets.dart';

class BalanceStoreScreen extends StatelessWidget {
  const BalanceStoreScreen({super.key});

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
            balance:
                '1000', //context.watch<AuthCubit>().state.balance.toString(),
            onTap: () {
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
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
