import 'package:driver_task/core/constants/app_colors.dart';
import 'package:driver_task/core/helpers/app_helper.dart';
import 'package:driver_task/features/tasks/presentation/widgets/package_tile.dart';
import 'package:driver_task/shared/components/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/constants/icon_path.dart';
import '../../../../core/routes/index.dart';
import '../../../../shared/components/custom_appbar.dart';
import '../../../../shared/components/custom_leading.dart';

class ScanPackagesPage extends StatefulWidget {
  const ScanPackagesPage({super.key, required this.taskDetailModel});
  final TaskDetailModel taskDetailModel;

  @override
  State<ScanPackagesPage> createState() => _ScanPackagesPageState();
}

class _ScanPackagesPageState extends State<ScanPackagesPage> {
  final Set<String> scannedBarcodes = {};
  final MobileScannerController cameraController = MobileScannerController();

  Future<void> _onDetect(BarcodeCapture capture) async {
    for (final barcode in capture.barcodes) {
      await Future.delayed(Duration(seconds: 2));
      final String? value = barcode.rawValue;
      print('Scanned barcode: $value');
      if (value != null &&
          !scannedBarcodes.contains(value) &&
          widget.taskDetailModel.packages.any(
            (package) => package.barcode == value,
          )) {
        setState(() {
          scannedBarcodes.add(value);
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    scannedBarcodes.clear();
    cameraController.dispose();
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
                  child: MobileScanner(
                    controller: cameraController,
                    onDetect: _onDetect,
                  ),
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
                '${scannedBarcodes.length} of ${widget.taskDetailModel.packages.length} ${'bags_scanned'.tr()}',
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
                                (e) => PackageTile(
                                  taskPackage: e,
                                  isScanned: scannedBarcodes.contains(
                                    e.barcode,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),

                      // Handover Button
                      CustomButton(
                        text: 'handover'.tr(),
                        isActive:
                            scannedBarcodes.length ==
                            widget.taskDetailModel.packages.length,
                        color: Colors.blue,
                        onTap: () {
                          AppHelper.showAnimationDialog(
                            barrierDismissible: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(IconPath.taskComplated),
                                8.verticalSpace,
                                Text(
                                  'complated_task'.tr(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                4.verticalSpace,
                                Text(
                                  'success_handover'.tr(),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                16.verticalSpace,
                                CustomButton(
                                  height: 50.h,
                                  text: 'next_task'.tr(),
                                  color: AppColors.blueColor,
                                  clickColor: AppColors.blueColor,
                                  textColor: Colors.white,
                                  onTap: () {
                                    context.go(Routes.taskList);
                                  },
                                ),
                              ],
                            ),
                            context: context,
                          );
                        },
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
