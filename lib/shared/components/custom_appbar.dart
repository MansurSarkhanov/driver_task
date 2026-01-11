import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_colors.dart';
import 'custom_leading.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.appBarHeight,
    this.actions,
    this.leading,
    required this.title,
    this.leadingWidth,
  });
  final double? appBarHeight;
  final double? leadingWidth;

  final List<Widget>? actions;
  final Widget? leading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: leadingWidth,
      leading:
          leading ??
          CustomLeading(
            bgColor: Colors.white,
            widthHeight: 40,
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onTab: () => context.pop(),
          ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: actions,
      centerTitle: true,
      backgroundColor: AppColors.backgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? kToolbarHeight);
}
