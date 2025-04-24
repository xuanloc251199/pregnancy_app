import 'dart:io';
import '../services/api_service.dart';

class BabyGeneratorRepository {
  Future<String?> uploadImage(File file) => ApiService.uploadImage(file);

  /// Gọi API Baby Generator và lấy về url ảnh em bé (tự động poll kết quả)
  Future<String?> generateBabyImage({
    required String fatherUrl,
    required String motherUrl,
    required String gender,
  }) async {
    // Gọi API lấy jobId
    final jobId = await ApiService.createBabyImage(
      fatherUrl: fatherUrl,
      motherUrl: motherUrl,
      gender: gender,
    );
    if (jobId == null) throw Exception('Không nhận được jobId!');

    // Polling để lấy kết quả (max 10 lần, mỗi lần chờ 3s)
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 3));
      final resultUrl = await ApiService.getBabyImageResult(jobId);
      if (resultUrl != null) return resultUrl;
    }
    throw Exception('Quá thời gian xử lý, vui lòng thử lại sau!');
  }
}
