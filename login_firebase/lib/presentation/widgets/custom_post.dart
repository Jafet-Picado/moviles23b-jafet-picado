import 'package:flutter/material.dart';

class CustomPost extends StatelessWidget {
  final String user;
  final String message;

  const CustomPost({
    super.key,
    required this.user,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      decoration: BoxDecoration(
        color: colors.secondaryContainer.withAlpha(50),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colors.secondaryContainer),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.primary,
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.person,
              color: colors.onPrimary,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: TextStyle(
                  color: colors.primary.withAlpha(200),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: TextStyle(
                  color: colors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
