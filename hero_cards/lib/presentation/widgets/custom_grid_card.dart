import 'package:flutter/material.dart';

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
    return Card(
      elevation: elevation,
      child: Column(
        children: [
          const SizedBox(height: 10),
          (image != null)
              ? CircleAvatar(
                  backgroundImage: NetworkImage(image!),
                  radius: 40,
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 15,
              overflow: TextOverflow.fade,
              fontFamily: 'Horizon',
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton.filled(
            onPressed: onPressedView,
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
