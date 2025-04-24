import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../repositories/auth_repository.dart';
import '../routes/app_route.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var rememberMe = true.obs;
  final box = GetStorage();
  final AuthRepository _authRepo = AuthRepository();

  void toggleRememberMe(bool value) {
    rememberMe.value = value;
    if (!value) {
      // Nếu bỏ chọn, xóa token (đăng xuất local)
      box.remove('token');
    }
  }

  bool get hasToken => box.hasData('token');

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      final result = await _authRepo.login(email, password);
      if (result['statusCode'] == 200) {
        String token = result['body']['token'];
        if (rememberMe.value) {
          box.write('token', token);
        }
        Get.snackbar('Thành công', 'Đăng nhập thành công!');
        Get.offAllNamed('/base');
      } else {
        Get.snackbar('Lỗi', result['body']['message'] ?? 'Đăng nhập thất bại');
      }
    } catch (_) {
      Get.snackbar('Lỗi', 'Không thể kết nối máy chủ');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password,
      String passwordConfirmation) async {
    isLoading.value = true;
    try {
      final result =
          await _authRepo.register(name, email, password, passwordConfirmation);
      if (result['statusCode'] == 200) {
        String token = result['body']['token'];
        if (rememberMe.value) {
          box.write('token', token);
        }
        Get.snackbar('Thành công', 'Đăng ký thành công!');
        Get.offAllNamed(AppRoutes.babydate);
        ;
      } else {
        Get.snackbar('Lỗi', result['body']['message'] ?? 'Đăng ký thất bại');
      }
    } catch (_) {
      Get.snackbar('Lỗi', 'Không thể kết nối máy chủ');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authRepo.logout();
    } catch (_) {}
    box.remove('token');
    Get.offAllNamed(AppRoutes.login);
  }

  // Logic điều hướng splash
  void handleAutoLogin() {
    if (hasToken && rememberMe.value) {
      Get.offAllNamed(AppRoutes.base);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
