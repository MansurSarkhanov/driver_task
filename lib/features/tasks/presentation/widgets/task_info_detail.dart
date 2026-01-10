import 'package:driver_task/core/constants/icon_path.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TaskInfoDetail extends StatelessWidget {
  const TaskInfoDetail({
    super.key,
    required this.title,
    required this.address,
    required this.etaMin,
    required this.distanceKm,
    required this.packagesCount,
  });

  final String title;
  final String address;
  final String etaMin;
  final double distanceKm;
  final int packagesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        4.verticalSpace,
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        4.verticalSpace,
        Text(
          address,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
        12.verticalSpace,
        Row(
          children: [
            _InfoItem(IconPath.clockPath, etaMin),
            12.w.horizontalSpace,
            _InfoItem(IconPath.locatoinPath, '$distanceKm km'),
            12.w.horizontalSpace,
            _InfoItem(IconPath.box18Path, "$packagesCount ${'bags'.tr()}"),
          ],
        ),
        16.verticalSpace,
        Divider(thickness: 1, color: Color(0xFFF0F0F0), height: 0),
        8.verticalSpace,
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String iconPath;
  final String text;

  const _InfoItem(this.iconPath, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        4.w.horizontalSpace,
        Text(
          text,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade700),
        ),
      ],
    );
  }
}
