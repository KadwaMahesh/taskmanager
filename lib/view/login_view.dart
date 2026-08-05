import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/widgets/app_button.dart';
import 'package:taskmanager/widgets/app_color.dart';
import 'package:taskmanager/widgets/app_text_style.dart';
import 'package:taskmanager/widgets/app_textfield.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login', style: AppTextStyle.subheadingStyle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.pageBackgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Sign In to TaskFlow',
                style: AppTextStyle.headingStyle,
              ),
              const SizedBox(height: 32),

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

              const SizedBox(height: 24),

              AppNavigationButton(
                buttonHeading: 'Login',
                icon: const Icon(Icons.login),
                onPressed: () {
                  final isValid = controller.validateLogin();

                  if (isValid) {
                    debugPrint(
                      'Login attempted with email: ${controller.emailController.text.trim()}',
                    );

                    Get.offAllNamed('/dashboard');
                    // or Get.toNamed('/dashboard');
                  }
                },
              ),

              const SizedBox(height: 20),

              Center(
                child: GestureDetector(
                  onTap: () => Get.toNamed('/register'),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextSpan(
                          text: 'Register',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
