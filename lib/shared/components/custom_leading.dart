import 'package:flutter/material.dart';

class CustomLeading extends StatelessWidget {
  final Widget icon;
  final Function() onTab;
  final double widthHeight;
  final Color bgColor;

  const CustomLeading({
    super.key,
    required this.icon,
    required this.onTab,
    this.widthHeight = 36,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        width: widthHeight,
        height: widthHeight,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000000).withValues(alpha: 0.16),
              blurRadius: 14,
            ),
          ],
        ),
        child: Center(child: icon),
      ),
    );
  }
}
