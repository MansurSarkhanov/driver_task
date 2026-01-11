import 'package:driver_task/core/constants/app_colors.dart';
import 'package:driver_task/features/tasks/presentation/bloc/cubit/task_list_cubit.dart';
import 'package:driver_task/features/tasks/presentation/bloc/state/task_list_states.dart';
import 'package:driver_task/features/tasks/presentation/widgets/language_tile.dart';
import 'package:driver_task/shared/shimmers/task_item_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/localization_manager.dart';
import '../../../../shared/components/custom_appbar.dart';
import '../widgets/task_timeline_list.dart';
import '../widgets/task_view_tabbar.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final ValueNotifier<TaskViewType> _viewType = ValueNotifier(
    TaskViewType.list,
  );
  final ValueNotifier<bool> _switchValue = ValueNotifier(true);

  @override
  void dispose() {
    _viewType.dispose();
    _switchValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      drawer: _drawer(context),
      appBar: _appBar(),
      body: _body(),
    );
  }

  Column _body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<TaskViewType>(
          valueListenable: _viewType,
          builder: (context, value, _) {
            return TaskViewTabBar(
              selected: value,
              onChanged: (newValue) {
                _viewType.value = newValue;
              },
            );
          },
        ),
        BlocBuilder<TaskListCubit, TaskListStates>(
          builder: (context, state) {
            if (state is TaskListLoading) {
              return Expanded(child: TaskItemShimmer(itemCount: 8));
            }
            if (state is TaskListSuccess) {
              return Expanded(
                child: RefreshIndicator(
                  color: AppColors.blueColor,
                  backgroundColor: Colors.white,
                  onRefresh: () async {
                    return context.read<TaskListCubit>().fetchTaskList();
                  },
                  child: TaskTimelineList(tasks: state.tasks),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }

  PreferredSizeWidget _appBar() {
    return CustomAppBar(
      title: 'tasks'.tr(),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        ValueListenableBuilder<bool>(
          valueListenable: _switchValue,
          builder: (context, value, _) {
            return CupertinoSwitch(
              value: value,
              onChanged: (val) {
                _switchValue.value = val;
              },
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFE7EEEE),
              activeTrackColor: AppColors.greenColor,
              trackOutlineWidth: WidgetStateProperty.all(0.1),
              trackOutlineColor: WidgetStateProperty.all(AppColors.greenColor),
            );
          },
        ),

        12.horizontalSpace,
      ],
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'language'.tr(),
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: LocalizationManager.supportedLanguages
                  .map(
                    (e) => LanguageTile(
                      title: e.name,
                      locale: e.locale,
                      context: context,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
