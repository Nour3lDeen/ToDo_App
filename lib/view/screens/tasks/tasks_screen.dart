import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_project/view/screens/auth/login_screen/login_screen.dart';
import 'package:tasks_project/view/screens/tasks/add_task_screen.dart';
import 'package:tasks_project/view_model/cubits/tasks_cubit/tasks_cubit.dart';
import 'package:tasks_project/view_model/data/local/shared_helper.dart';
import 'package:tasks_project/view_model/utils/app_colors.dart';
import '../../../translation/locale_keys.g.dart';
import '../../../view_model/utils/navigation.dart';
import 'components/task_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: TasksCubit.get(context)..getTasks(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.white),
          title: Text(
            LocaleKeys.todoApp.tr(),
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          backgroundColor: AppColors.purple,
          actions: [
            InkWell(
              onTap: () {},
              child: const Icon(
                Icons.filter_list_outlined,
                color: AppColors.white,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            InkWell(
              onTap: () {
                SharedHelper.clearData();
                Navigation.pushAndRemove(context, const LoginScreen());
              },
              child: const Icon(
                Icons.logout_outlined,
                color: AppColors.white,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
          centerTitle: false,
        ),
        body: ListView.separated(
          padding: EdgeInsets.all(12.sp),
          itemBuilder: (context, index) {
            return TaskWidget(
              task: TasksCubit.get(context).tasks[index],
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 12.h,
            );
          },
          itemCount: TasksCubit.get(context).tasks.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.purple,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add_outlined,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
