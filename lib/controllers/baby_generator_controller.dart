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

  void pickAndUploadDadImage(File file) async {
    final url = await repo.uploadImage(file);
    if (url != null) dadImageUrl.value = url;
  }

  void pickAndUploadMomImage(File file) async {
    final url = await repo.uploadImage(file);
    if (url != null) momImageUrl.value = url;
  }

  void generateBaby() async {
    if (dadImageUrl.value.isEmpty ||
        momImageUrl.value.isEmpty ||
        gender.value.isEmpty) {
      Get.snackbar('Lỗi', 'Vui lòng chọn đầy đủ ảnh và giới tính');
      return;
    }
    isLoading.value = true;
    babyImageUrl.value = '';
    try {
      final url = await repo.generateBabyImage(
        fatherUrl: dadImageUrl.value,
        motherUrl: momImageUrl.value,
        gender: gender.value,
      );
      babyImageUrl.value = url ?? '';
      if (url == null) Get.snackbar('Lỗi', 'Không tạo được ảnh!');
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
