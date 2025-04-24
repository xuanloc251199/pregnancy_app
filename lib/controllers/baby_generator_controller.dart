import 'dart:io';
import 'package:get/get.dart';

import '../repositories/baby_generator_repository.dart';

class BabyGeneratorController extends GetxController {
  final repo = BabyGeneratorRepository();

  var dadImageUrl = ''.obs;
  var momImageUrl = ''.obs;
  var babyImageUrl = ''.obs;
  var gender = 'babyBoy'.obs;
  var isLoading = false.obs;

  void logMessage(String message) {
    final time = DateTime.now().toIso8601String();
    print('[$time] $message'); // HIỂN THỊ Ở TERMINAL
  }

  void pickAndUploadDadImage(File file) async {
    logMessage('Đang upload ảnh Bố...');
    try {
      final url = await repo.uploadImage(file);
      if (url != null) {
        dadImageUrl.value = url;
        logMessage('Upload ảnh Bố thành công: $url');
      } else {
        logMessage('Upload ảnh Bố thất bại!');
        Get.snackbar('Lỗi', 'Upload ảnh Bố thất bại!');
      }
    } catch (e) {
      logMessage('Lỗi khi upload ảnh Bố: $e');
      Get.snackbar('Lỗi', 'Lỗi khi upload ảnh Bố: $e');
    }
  }

  void pickAndUploadMomImage(File file) async {
    logMessage('Đang upload ảnh Mẹ...');
    try {
      final url = await repo.uploadImage(file);
      if (url != null) {
        momImageUrl.value = url;
        logMessage('Upload ảnh Mẹ thành công: $url');
      } else {
        logMessage('Upload ảnh Mẹ thất bại!');
        Get.snackbar('Lỗi', 'Upload ảnh Mẹ thất bại!');
      }
    } catch (e) {
      logMessage('Lỗi khi upload ảnh Mẹ: $e');
      Get.snackbar('Lỗi', 'Lỗi khi upload ảnh Mẹ: $e');
    }
  }

  void generateBaby() async {
    if (dadImageUrl.value.isEmpty ||
        momImageUrl.value.isEmpty ||
        gender.value.isEmpty) {
      logMessage('Thiếu ảnh hoặc giới tính!');
      Get.snackbar('Lỗi', 'Vui lòng chọn đầy đủ ảnh và giới tính');
      return;
    }
    isLoading.value = true;
    babyImageUrl.value = '';
    logMessage('Bắt đầu tạo ảnh em bé...');
    try {
      final url = await repo.generateBabyImage(
        fatherUrl: dadImageUrl.value,
        motherUrl: momImageUrl.value,
        gender: gender.value,
      );
      babyImageUrl.value = url ?? '';
      if (url == null) {
        logMessage('Không tạo được ảnh em bé!');
        Get.snackbar('Lỗi', 'Không tạo được ảnh!');
      } else {
        logMessage('Tạo ảnh em bé thành công: $url');
      }
    } catch (e) {
      logMessage('Lỗi khi tạo ảnh em bé: $e');
      Get.snackbar('Lỗi', e.toString());
    } finally {
      isLoading.value = false;
      logMessage('Kết thúc process.');
    }
  }
}
