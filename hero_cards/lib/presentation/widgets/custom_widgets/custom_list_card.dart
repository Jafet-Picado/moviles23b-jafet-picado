import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CustomListCard extends StatelessWidget {
  final double? elevation;
  final String? title;
  final String? image;
  final void Function()? onPressedView;

  const CustomListCard({
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
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Row(
          children: [
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
            const SizedBox(width: 10),
            SizedBox(
              width: (MediaQuery.of(context).size.width - 30) / 2,
              child: Text(
                title ?? '',
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Horizon',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            CircleAvatar(
              radius: 20,
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
