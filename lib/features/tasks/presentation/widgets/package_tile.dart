import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/icon_path.dart';
import '../../data/models/task_detail_response.dart';

class PackageTile extends StatelessWidget {
  const PackageTile({super.key, required this.taskPackage, this.isScanned});
  final TaskPackage taskPackage;
  final bool? isScanned;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          (isScanned ?? false)
              ? const Icon(Icons.check, color: Colors.green)
              : SvgPicture.asset(IconPath.boxPath),
          8.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(taskPackage.packageId),
              Text("${taskPackage.shipmentId} ${'shipment'.tr()}"),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [Text("Barcode"), Text(taskPackage.barcode)],
          ),
        ],
      ),
    );
  }
}
