import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.locale,
    required this.title,
    required this.context,
  });
  final Locale locale;
  final String title;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final isSelected = this.context.locale == locale;
    return ListTile(
      leading: Icon(
        Icons.language,
        color: isSelected ? AppColors.blueColor : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: AppColors.blueColor)
          : null,
      onTap: () async {
        await context.setLocale(locale);
        Navigator.of(context).pop(); // drawer bağlanır
      },
    );
  }
}
