import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/enums/status_enum.dart';
import '../../data/models/task_list_model.dart';
import '../screens/task_detail_screen.dart';
import 'task_info_detail.dart';

class TaskTimelineList extends StatelessWidget {
  const TaskTimelineList({super.key, required this.tasks});
  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: Duration(milliseconds: 500),
          child: SlideAnimation(
            verticalOffset: 60.0,
            child: TaskTimelineItem(
              task: tasks[index],
              isActive: tasks[index].status == StatusEnum.progress.name,
            ),
          ),
        );
      },
    );
  }
}

class TaskTimelineItem extends StatelessWidget {
  final TaskModel task;
  final bool isActive;

  const TaskTimelineItem({
    super.key,
    required this.task,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (task.status == 'in_progress') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TaskDetailScreen(id: task.taskId),
            ),
          );
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _CircleNumber(number: task.priority, isActive: isActive),
              Container(width: 1, height: 84.h, color: AppColors.blackColor),
            ],
          ),
          12.horizontalSpace,
          Expanded(
            child: TaskInfoDetail(
              address: task.address,
              distanceKm: task.distanceKm,
              etaMin: '${task.etaMin} min',
              packagesCount: task.packagesCount,
              title: task.title,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleNumber extends StatelessWidget {
  final int number;
  final bool isActive;

  const _CircleNumber({required this.number, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withValues(alpha: 0.25),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: 20.r,
          height: 20.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : AppColors.greenColor,
            shape: BoxShape.circle,
          ),
          child: Text(
            number.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
