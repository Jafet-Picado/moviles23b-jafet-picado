import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          padding: const EdgeInsets.only(left: 1),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
