import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  Future<void> registerUser(String email, String password) async {
    const String baseUrl = "http://your-server-url.com";
    const String registerUrl = "$baseUrl/register";

    try {
      final response = await http.post(
        Uri.parse(registerUrl),
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        // Navigate to the login screen or dashboard
        Get.snackbar('Success', 'Registration successful');
        Get.toNamed('/login');
      } else {
        // Show error message
        Get.snackbar('Error', 'Failed to register: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error connecting to server: $e');
    }
  }
}
