import 'package:flaapp/services/constant/theme/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    this.backgroundColor,
    required this.onTap,
    this.enabled = true,
    super.key,
  });

  final String label;
  final Color? backgroundColor;
  final Function()? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ElevatedButton(
      onPressed: enabled ? onTap : null,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        backgroundColor: backgroundColor ?? ColorTheme.tBlueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodyMedium!.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
