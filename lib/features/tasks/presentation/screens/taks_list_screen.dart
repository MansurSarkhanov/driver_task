import 'package:driver_task/core/constants/app_colors.dart';
import 'package:driver_task/features/tasks/presentation/bloc/cubit/task_list_cubit.dart';
import 'package:driver_task/features/tasks/presentation/bloc/state/task_list_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/task_timeline_list.dart';
import '../widgets/task_view_tabbar.dart';

class TaksListScreen extends StatefulWidget {
  const TaksListScreen({super.key});

  @override
  State<TaksListScreen> createState() => _TaksListScreenState();
}

class _TaksListScreenState extends State<TaksListScreen> {
  TaskViewType _viewType = TaskViewType.list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Column _body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TaskViewTabBar(
          selected: _viewType,
          onChanged: (value) {
            setState(() {
              _viewType = value;
            });
          },
        ),
        BlocBuilder<TaskListCubit, TaskListStates>(
          builder: (context, state) {
            if (state is TaskListLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            }
            if (state is TaskListSuccess) {
              return Expanded(child: TaskTimelineList(tasks: state.tasks));
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      title: Text(
        'tasks'.tr(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        CupertinoSwitch(
          value: true,
          onChanged: (val) {},
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Color(0xFFE7EEEE),
          activeTrackColor: AppColors.greenColor,
          trackOutlineColor: WidgetStateProperty.all(AppColors.greenColor),
        ),
        12.horizontalSpace,
      ],
      centerTitle: true,
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
