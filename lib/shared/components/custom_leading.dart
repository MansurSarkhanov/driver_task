import 'package:flutter/material.dart';

class CustomLeading extends StatelessWidget {
  final Widget icon;
  final Function() onTab;
  final double widthHeight;
  final Color bgColor;
  final Color? borderColor;

  final List<BoxShadow>? boxShadow;

  const CustomLeading({
    super.key,
    required this.icon,
    required this.onTab,
    this.widthHeight = 36,
    required this.bgColor,
    this.boxShadow,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        width: widthHeight,
        height: widthHeight,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: boxShadow,
        ),
        child: Center(child: icon),
      ),
    );
  }
}
