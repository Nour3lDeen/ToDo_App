import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tasks_project/my_app.dart';
import 'package:tasks_project/view_model/data/local/shared_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedHelper.init();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translation',
        fallbackLocale: const Locale('en'),
       child : const MyApp()),
  );
}
