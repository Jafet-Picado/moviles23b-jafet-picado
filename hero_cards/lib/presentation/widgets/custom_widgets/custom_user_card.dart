import 'package:flutter/material.dart';

class CustomUserCard extends StatelessWidget {
  final double? elevation;
  final Map<String, dynamic> user;

  const CustomUserCard({
    super.key,
    this.elevation,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: colors.secondaryContainer,
                  child: Icon(
                    Icons.person_rounded,
                    size: 35,
                    color: colors.onBackground,
                  ),
                ),
                Positioned(
                  right: 3,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(7.5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(90.0),
                      color: (user['isOnline']) ? Colors.green : Colors.grey,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              user['username'] ?? '',
              style: const TextStyle(
                fontSize: 15,
                overflow: TextOverflow.fade,
                fontFamily: 'Horizon',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              '\' ${user['bio']} \'',
              style: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'HeroCoins: ',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Horizon',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 5),
                Text(
                  user['balance'].toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Cantidad de cartas: ',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Horizon',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 5),
                Text(
                  user['cards'].length.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
