import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final GetStorage _storage = GetStorage();

  static const String _isLoggedInKey = 'isLoggedIn';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  bool get isUserLoggedIn => _storage.read(_isLoggedInKey) ?? false;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    await Future.delayed(Duration(milliseconds: 600));

    await _storage.write(_isLoggedInKey, true);

    isLoading.value = false;

    Get.offAllNamed('/dashboard');
  }

  void logout() async {
    await _storage.remove(_isLoggedInKey);
    emailController.clear();
    passwordController.clear();
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
