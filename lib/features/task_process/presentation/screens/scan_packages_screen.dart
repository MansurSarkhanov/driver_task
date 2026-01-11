import 'package:driver_task/core/constants/app_colors.dart';
import 'package:driver_task/shared/components/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/constants/icon_path.dart';
import '../../../../shared/components/custom_appbar.dart';
import '../../../../shared/components/custom_leading.dart';
import '../../../tasks/data/models/task_detail_response.dart';

class ScanPackagesPage extends StatefulWidget {
  const ScanPackagesPage({super.key, required this.taskDetailModel});
  final TaskDetailModel taskDetailModel;

  @override
  State<ScanPackagesPage> createState() => _ScanPackagesPageState();
}

class _ScanPackagesPageState extends State<ScanPackagesPage> {
  final Set<String> scannedBarcodes = {};

  void _onDetect(BarcodeCapture capture) {
    for (final barcode in capture.barcodes) {
      final String? value = barcode.rawValue;
      if (value != null && !scannedBarcodes.contains(value)) {
        setState(() {
          scannedBarcodes.add(value);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'scan_packages'.tr(),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CustomLeading(
            borderColor: Color(0xFFD9D9D9),
            bgColor: Colors.white,
            widthHeight: 40,
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onTab: () => context.pop(),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: MobileScanner(onDetect: _onDetect),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Icon(Icons.flash_on, color: Colors.white),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Icon(Icons.text_fields, color: Colors.white),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 70),
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.black,
              child: Text(
                '${scannedBarcodes.length} of ${widget.taskDetailModel.packages.length} bag(s) scanned',
                style: const TextStyle(color: Colors.white),
              ),
            ),

            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: widget.taskDetailModel.packages
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(IconPath.boxPath),
                                      8.horizontalSpace,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(e.packageId),
                                          Text("${e.shipmentId} shipment"),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Barcode"),
                                          Text(e.barcode),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),

                      // Handover Button
                      CustomButton(
                        text: 'Handover',
                        color:
                            scannedBarcodes.length ==
                                widget.taskDetailModel.packages.length
                            ? Colors.blue
                            : Colors.grey[300],
                        onTap:
                            scannedBarcodes.length ==
                                widget.taskDetailModel.packages.length
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Handover completed'),
                                  ),
                                );
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
