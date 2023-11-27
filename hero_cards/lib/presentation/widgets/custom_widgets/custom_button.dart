import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool? icon;

  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: colors.secondaryContainer,
            borderRadius: BorderRadius.circular(15),
          ),
          child: (icon == null || icon == false)
              ? Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: colors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.fingerprint_rounded, size: 50)
                    ],
                  ),
                )),
    );
  }
}
