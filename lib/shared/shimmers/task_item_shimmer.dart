import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TaskItemShimmer extends StatelessWidget {
  const TaskItemShimmer({super.key, required this.itemCount});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline circle + line
                Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    Container(width: 2, height: 60, color: Colors.white),
                  ],
                ),
                const SizedBox(width: 12),

                // Main content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title bar
                      Container(height: 14, width: 120, color: Colors.white),
                      const SizedBox(height: 8),

                      // Address line
                      Container(height: 12, width: 160, color: Colors.white),
                      const SizedBox(height: 16),

                      // Info icons row
                      Row(
                        children: [
                          Container(width: 80, height: 12, color: Colors.white),
                          const SizedBox(width: 12),
                          Container(width: 60, height: 12, color: Colors.white),
                          const SizedBox(width: 12),
                          Container(width: 70, height: 12, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
