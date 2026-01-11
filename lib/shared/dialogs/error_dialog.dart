import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/app_colors.dart';
import '../components/custom_button.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LottieBuilder.asset('assets/jsons/error_404.json', width: 200),
        8.verticalSpace,
        Text(
          message,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        16.verticalSpace,
        const Divider(thickness: 0.3, color: Color(0xFFA0A0A0)),
        4.verticalSpace,
        CustomButton(
          height: 50.h,
          text: 'OK',
          color: AppColors.blueColor,
          clickColor: AppColors.blueColor,
          textColor: Colors.white,
          onTap: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
