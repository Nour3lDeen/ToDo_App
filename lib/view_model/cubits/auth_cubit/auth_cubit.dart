import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../data/local/shared_helper.dart';
import '../../data/local/shared_keys.dart';
import '../../data/network/dio_helper.dart';
import '../../data/network/end_points.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(
    text: SharedHelper.getData(SharedKeys.email),
  );
  TextEditingController passwordController = TextEditingController();

  bool showPassword = true;

  void changePasswordVisibility() {
    showPassword = !showPassword;
    emit(ChangePasswordVisibilityState());
  }

  void login() async {
    emit(LoginLoadingState());
    await DioHelper.post(
      path: EndPoints.login,
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    ).then((value) {
      SharedHelper.saveData(
          SharedKeys.userName, value.data['data']['user']['name']);
      SharedHelper.saveData(
          SharedKeys.email, value.data['data']['user']['email']);
      SharedHelper.saveData(SharedKeys.token, value.data['data']['token']);
      emit(LoginSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        emit(LoginErrorState(
          error.response?.data['message'] ?? 'Error on Login',
        ));
      }
    });
  }
}
