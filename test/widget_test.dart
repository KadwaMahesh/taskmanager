import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:taskmanager/controllers/auth_controller.dart';
import 'package:taskmanager/main.dart';

void main() {
  testWidgets('Login screen loads successfully', (WidgetTester tester) async {
    // Register the controller
    Get.put(AuthController());

    // Build the app
    await tester.pumpWidget(const GetMaterialApp());

    // Wait for widgets to build
    await tester.pumpAndSettle();

    // Verify Login screen
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Sign In to TaskFlow'), findsOneWidget);

    // Verify Email field
    expect(find.text('Email'), findsOneWidget);

    // Verify Password field
    expect(find.text('Password'), findsOneWidget);

    // Verify Login button
    expect(find.text('Login'), findsWidgets);
  });
}
