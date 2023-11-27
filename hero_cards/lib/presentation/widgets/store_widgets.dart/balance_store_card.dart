import 'package:flutter/material.dart';

class BalanceStoreCard extends StatelessWidget {
  final String image;
  final String title;
  final String amount;
  final String price;
  final void Function()? onTap;
  final Color? iconColor;
  final Color? titleColor;

  const BalanceStoreCard({
    super.key,
    required this.image,
    required this.title,
    required this.amount,
    required this.price,
    required this.onTap,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 8,
      child: SizedBox(
        width: 300,
        height: 310,
        child: Column(
          children: [
            const SizedBox(height: 5),
            Image.network(
              image,
              color: iconColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Paquete',
                  style: TextStyle(
                    fontFamily: 'Horizon',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Horizon',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              '$amount HeroCoins',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Text(
              'Precio:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '₡$price',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                width: 120,
                child: Chip(
                  label: const Row(
                    children: [
                      Icon(Icons.receipt_rounded),
                      SizedBox(width: 5),
                      Text('Comprar'),
                    ],
                  ),
                  backgroundColor: colors.primaryContainer,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
