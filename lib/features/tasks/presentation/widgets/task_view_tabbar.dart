import 'package:driver_task/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TaskViewType { list, map }

class TaskViewTabBar extends StatelessWidget {
  final TaskViewType selected;
  final ValueChanged<TaskViewType> onChanged;

  const TaskViewTabBar({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.unselectedTabColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          _TabItem(
            title: "list".tr(),
            isActive: selected == TaskViewType.list,
            onTap: () => onChanged(TaskViewType.list),
          ),
          _TabItem(
            title: "map".tr(),
            isActive: selected == TaskViewType.map,
            onTap: () => onChanged(TaskViewType.map),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          margin: EdgeInsets.all(4.dm),
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.blackColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.dm),
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.blackColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
