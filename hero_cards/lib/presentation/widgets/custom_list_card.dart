import 'package:flutter/material.dart';

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
    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Row(
          children: [
            (image != null)
                ? CircleAvatar(
                    backgroundImage: NetworkImage(image!),
                    radius: 40,
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
            IconButton.filled(
                onPressed: onPressedView,
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                )),
          ],
        ),
      ),
    );
  }
}
