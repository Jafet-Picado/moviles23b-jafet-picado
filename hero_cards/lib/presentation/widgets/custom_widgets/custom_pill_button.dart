import 'package:flutter/material.dart';

class CustomPillButton extends StatefulWidget {
  final void Function()? onTap;
  final String balance;
  const CustomPillButton({
    super.key,
    required this.onTap,
    required this.balance,
  });

  @override
  State<CustomPillButton> createState() => _CustomPillButtonState();
}

class _CustomPillButtonState extends State<CustomPillButton> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Chip(
      label: Text(widget.balance),
      backgroundColor: colors.primaryContainer,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 10,
      avatar: Icon(
        Icons.account_balance_wallet_sharp,
        color: colors.onPrimaryContainer,
      ),
      deleteIcon: const Icon(
        Icons.add,
        size: 20,
      ),
      onDeleted: widget.onTap,
    );
  }
}
