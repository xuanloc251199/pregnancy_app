import 'dart:io';
import 'package:get/get.dart';
import '../repositories/user_repository.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<Map<String, dynamic>>();
  final userRepo = UserRepository();
  Rx<File?> avatarFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void fetchProfile() async {
    isLoading.value = true;
    final data = await userRepo.getProfile();
    user.value = data;
    isLoading.value = false;
  }

  Future<void> updateProfile({
    String? name,
    String? address,
    String? phone,
    File? avatar,
  }) async {
    isLoading.value = true;
    final result = await userRepo.updateProfile(
      name: name,
      address: address,
      phone: phone,
      avatar: avatar,
    );
    if (result['statusCode'] == 200) {
      Get.snackbar('Thành công', 'Cập nhật thành công!');
      fetchProfile();
    } else {
      Get.snackbar('Lỗi', result['body']['message'] ?? 'Lỗi cập nhật');
    }
    isLoading.value = false;
  }

  Future<void> changePassword(
      String oldPass, String newPass, String confirm) async {
    isLoading.value = true;
    final result = await userRepo.changePassword(oldPass, newPass, confirm);
    if (result['statusCode'] == 200) {
      Get.snackbar('Thành công', 'Đổi mật khẩu thành công!');
    } else {
      Get.snackbar('Lỗi', result['body']['message'] ?? 'Đổi mật khẩu thất bại');
    }
    isLoading.value = false;
  }
}
