import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CustomSliderCard extends StatelessWidget {
  final String name;
  final String image;
  final String publisher;
  final String price;
  final void Function()? onTap;
  const CustomSliderCard({
    super.key,
    required this.name,
    required this.image,
    required this.publisher,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: colors.secondaryContainer,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(1.0, 2.0),
          )
        ],
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop(this);
                        },
                        child: PhotoView(
                          imageProvider: Image.network(
                            image,
                          ).image,
                        ),
                      );
                    });
              },
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(60),
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/noimagen.jpg',
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Horizon',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              publisher,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Horizon',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const Text(
              'Precio:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              '$price HeroCoins',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const Expanded(child: SizedBox()),
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
