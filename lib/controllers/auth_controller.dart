import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final nameError = RxnString();
  final emailError = RxnString();
  final passwordError = RxnString();
  final confirmPasswordError = RxnString();

  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  bool validateRegister() {
    nameError.value = nameController.text.trim().isEmpty
        ? 'Name is required'
        : null;

    final email = emailController.text.trim();
    if (email.isEmpty) {
      emailError.value = 'Email is required';
    } else if (!RegExp(
      r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$',
    ).hasMatch(email)) {
      emailError.value = 'Enter a valid email';
    } else {
      emailError.value = null;
    }

    final password = passwordController.text;
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
    } else if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
    } else {
      passwordError.value = null;
    }

    final confirmPassword = confirmPasswordController.text;
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Confirm password is required';
    } else if (confirmPassword != password) {
      confirmPasswordError.value = 'Passwords do not match';
    } else {
      confirmPasswordError.value = null;
    }

    return nameError.value == null &&
        emailError.value == null &&
        passwordError.value == null &&
        confirmPasswordError.value == null;
  }

  bool validateLogin() {
    emailError.value = null;
    passwordError.value = null;

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty) {
      emailError.value = 'Email is required';
    } else if (!RegExp(
      r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$',
    ).hasMatch(email)) {
      emailError.value = 'Enter a valid email';
    }

    if (password.isEmpty) {
      passwordError.value = 'Password is required';
    } else if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
    }

    return emailError.value == null && passwordError.value == null;
  }
}
