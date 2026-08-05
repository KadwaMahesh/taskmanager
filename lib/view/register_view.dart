import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/controllers/auth_controller.dart';
import 'package:taskmanager/widgets/app_button.dart';
import 'package:taskmanager/widgets/app_color.dart';
import 'package:taskmanager/widgets/app_text_style.dart';
import 'package:taskmanager/widgets/app_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.clearForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Register', style: AppTextStyle.subheadingStyle),
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
              const SizedBox(height: 16),
              const Text(
                'Create your account',
                style: AppTextStyle.headingStyle,
              ),
              const SizedBox(height: 28),

              Obx(
                () => AppTextfield(
                  controller: controller.nameController,
                  hintText: 'Name',
                  prefixIcon: const Icon(Icons.person_outline),
                  errorText: controller.nameError.value,
                  onChanged: (_) => controller.nameError.value = null,
                ),
              ),

              const SizedBox(height: 16),

              Obx(
                () => AppTextfield(
                  controller: controller.emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.mail_outline),
                  errorText: controller.emailError.value,
                  onChanged: (_) => controller.emailError.value = null,
                ),
              ),

              const SizedBox(height: 16),

              Obx(
                () => AppTextfield(
                  controller: controller.passwordController,
                  hintText: 'Password',
                  obscureText: controller.obscurePassword.value,
                  prefixIcon: const Icon(Icons.lock_outline),
                  errorText: controller.passwordError.value,
                  onChanged: (_) => controller.passwordError.value = null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.obscurePassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      controller.obscurePassword.toggle();
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Obx(
                () => AppTextfield(
                  controller: controller.confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: controller.obscureConfirmPassword.value,
                  prefixIcon: const Icon(Icons.lock_outline),
                  errorText: controller.confirmPasswordError.value,
                  onChanged: (_) =>
                      controller.confirmPasswordError.value = null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.obscureConfirmPassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      controller.obscureConfirmPassword.toggle();
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),

              AppNavigationButton(
                buttonHeading: 'Register',
                icon: const Icon(Icons.person_add_alt_1),
                onPressed: () {
                  if (controller.validateRegister()) {
                    debugPrint('Registration Successful');

                    Get.offNamed('/dashboard');
                  }
                },
              ),

              const SizedBox(height: 20),

              Center(
                child: GestureDetector(
                  onTap: () {
                    controller.clearForm();
                    Get.back();
                  },
                  child: RichText(
                    text: TextSpan(
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
