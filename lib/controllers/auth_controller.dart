import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pregnancy_app/repositories/user_repository.dart';
import 'package:pregnancy_app/routes/app_route.dart';

class AuthController extends GetxController {
  final UserRepository userRepository;

  AuthController({required this.userRepository});

  // Lưu token vào SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Lấy token từ SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Xử lý đăng ký người dùng
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      final response = await userRepository.register({
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      });

      if (response.statusCode == 200) {
        final token = response.data['access_token'];

        // Lưu token vào SharedPreferences
        await _saveToken(token);

        Get.snackbar('Success', 'Registration successful');
        Get.offAllNamed(AppRoutes.instruct);
      } else {
        Get.snackbar('Error', response.data['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Registration failed');
    }
  }
}
