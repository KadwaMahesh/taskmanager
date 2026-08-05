import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskmanager/modules/auth_binding.dart';
import 'package:taskmanager/view/dashbord_view.dart';
import 'package:taskmanager/view/login_view.dart';
import 'package:taskmanager/view/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      title: 'Field Task Manager',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/dashboard',
          page: () => const DashboardScreen(),
          binding: AuthBinding(),
        ),
      ],
    ),
  );
}
