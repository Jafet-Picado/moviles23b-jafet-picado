import 'package:flutter/material.dart';

class CustomLikeButton extends StatelessWidget {
  final bool isLiked;
  final String numberOfLikes;
  final void Function()? onTap;

  const CustomLikeButton({
    super.key,
    required this.isLiked,
    required this.numberOfLikes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? colors.primary : colors.secondaryContainer,
          ),
        ),
        const SizedBox(height: 3),
        Text(numberOfLikes),
      ],
    );
  }
}
