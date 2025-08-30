import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flutter/material.dart';

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.backgroundColor,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorTheme.tWhiteColor,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: ColorTheme.tGreyColor,
          ),
        ),
        child: child,
      ),
    );
  }
}
