import 'package:get/get.dart';
import 'package:pregnancy_app/routes/app_route.dart';
import '../repositories/pregnancy_info_repository.dart';

class PregnancyInfoController extends GetxController {
  final repo = PregnancyInfoRepository();
  var isLoading = false.obs;
  var savedPregnantDate = Rxn<DateTime>(); // ngày đã lưu từ backend

  Future<void> savePregnancyDate(String pregnantDate) async {
    isLoading.value = true;
    try {
      final result = await repo.savePregnancyDate(pregnantDate: pregnantDate);
      if (result['statusCode'] == 200) {
        // Lưu lại ngày đã lưu
        savedPregnantDate.value =
            DateTime.parse(result['body']['data']['pregnant_date']);
        Get.snackbar('Thành công', 'Lưu ngày mang thai thành công!');
        Get.offAllNamed(AppRoutes.base);
      } else {
        Get.snackbar('Lỗi', result['body']['message'] ?? 'Lưu thất bại');
      }
    } catch (_) {
      Get.snackbar('Lỗi', 'Không thể kết nối máy chủ');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPregnancyInfo() async {
    final data = await repo.getPregnancyInfo();
    if (data != null && data['pregnant_date'] != null) {
      savedPregnantDate.value = DateTime.parse(data['pregnant_date']);
    }
  }
}
