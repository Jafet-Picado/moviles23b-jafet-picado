import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CustomGridCard extends StatelessWidget {
  final double? elevation;
  final String? title;
  final String? image;
  final void Function()? onPressedView;

  const CustomGridCard({
    super.key,
    this.elevation,
    this.title,
    this.onPressedView,
    this.image,
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
            (image != null)
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(this);
                              },
                              child: PhotoView(
                                imageProvider: Image.network(
                                  image!,
                                ).image,
                              ),
                            );
                          });
                    },
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(40),
                        child: Image.network(
                          image!,
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
                  )
                : const SizedBox(),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                    overflow: TextOverflow.fade,
                    fontFamily: 'Horizon',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            CircleAvatar(
              radius: 22,
              backgroundColor: colors.secondaryContainer,
              child: IconButton(
                onPressed: onPressedView,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: colors.onBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
