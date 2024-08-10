import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_project/view_model/cubits/auth_cubit/auth_cubit.dart';
import 'package:tasks_project/view_model/utils/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_project/view_model/utils/navigation.dart';
import '../../../../translation/locale_keys.g.dart';
import '../../../../view_model/utils/app_colors.dart';
import '../../../../view_model/utils/snack_bar_helper.dart';
import '../../tasks/tasks_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: AuthCubit.get(context).formKey,
        child: ListView(
          padding: EdgeInsets.all(18.sp),
          children: [
            SizedBox(
              height: 40.h,
            ),
            Image.asset(
              AppAssets.todo,
              height: 150.h,
            ),
            SizedBox(
              height: 12.h,
            ),
            Center(
              child: Text(
                LocaleKeys.login.tr(),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: AuthCubit.get(context).emailController,
              onTapOutside: (event) {
                return FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                  labelText: LocaleKeys.email.tr(),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.black,
                      ))),
              validator: (value) {
                if ((value ?? '').trim().isEmpty) {
                  return LocaleKeys.emailError.tr();
                }
                return null;
              },
            ),
            SizedBox(
              height: 6.h,
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return TextFormField(
                  obscureText: AuthCubit.get(context).showPassword,
                  controller: AuthCubit.get(context).passwordController,
                  onTapOutside: (event) {
                    return FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            AuthCubit.get(context).changePasswordVisibility();
                          },
                          icon: AuthCubit.get(context).showPassword
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      labelText: LocaleKeys.password.tr(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            width: 1.w,
                            color: AppColors.black,
                          ))),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return LocaleKeys.passwordError.tr();
                    }
                    return null;
                  },
                );
              },
            ),
            SizedBox(
              height: 22.h,
            ),
            Row(
              children: [
                Text(
                  LocaleKeys.doNotHaveAnAccount.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      LocaleKeys.register.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.blue,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 22.h,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  SnackBarHelper.showMessage(context, 'Login Successfully');
                  Navigation.pushAndRemove(context, const TasksScreen());
                } else if (state is LoginErrorState) {
                  SnackBarHelper.showError(context, state.msg);
                }
              },
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  return const CircularProgressIndicator.adaptive();
                }
                return ElevatedButton(
                  onPressed: () {
                    if (AuthCubit.get(context)
                        .formKey
                        .currentState!
                        .validate()) {
                      AuthCubit.get(context).login();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.login.tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
