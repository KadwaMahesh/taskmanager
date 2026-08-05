import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastmanager/widgets/app_button.dart';
import 'package:tastmanager/widgets/app_text_style.dart';
import 'package:tastmanager/widgets/app_textfield.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register', style: AppTextStyle.subheadingStyle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Create your account',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 28),

              Obx(
                () => AppTextfield(
                  controller: controller.nameController,
                  hintText: 'Name',
                  prefixIcon: const Icon(Icons.person_outline),
                  errorText: controller.nameError.value,
                  onChanged: (_) {
                    if (controller.nameError.value != null) {
                      controller.nameError.value = null;
                    }
                  },
                ),
              ),

              const SizedBox(height: 16),

              Obx(
                () => AppTextfield(
                  controller: controller.emailController,
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.mail_outline),
                  keyboardType: TextInputType.emailAddress,
                  errorText: controller.emailError.value,
                  onChanged: (_) {
                    if (controller.emailError.value != null) {
                      controller.emailError.value = null;
                    }
                  },
                ),
              ),

              const SizedBox(height: 16),

              Obx(
                () => AppTextfield(
                  controller: controller.passwordController,
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  obscureText: controller.obscurePassword.value,
                  errorText: controller.passwordError.value,
                  onChanged: (_) {
                    if (controller.passwordError.value != null) {
                      controller.passwordError.value = null;
                    }
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.obscurePassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      controller.obscurePassword.value =
                          !controller.obscurePassword.value;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Obx(
                () => AppTextfield(
                  controller: controller.confirmPasswordController,
                  hintText: 'Confirm password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  obscureText: controller.obscureConfirmPassword.value,
                  errorText: controller.confirmPasswordError.value,
                  onChanged: (_) {
                    if (controller.confirmPasswordError.value != null) {
                      controller.confirmPasswordError.value = null;
                    }
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.obscureConfirmPassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      controller.obscureConfirmPassword.value =
                          !controller.obscureConfirmPassword.value;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),

              AppNavigationButton(
                buttonHeading: 'Register',
                icon: const Icon(Icons.person_add_alt_1),
                onPressed: () {
                  final isValid = controller.validateRegister();
                  if (isValid) {
                    debugPrint(
                      'Registering user: ${controller.emailController.text.trim()}',
                    );
                  }
                },
              ),

              const SizedBox(height: 20),

              Center(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
