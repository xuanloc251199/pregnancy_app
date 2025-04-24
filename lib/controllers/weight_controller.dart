import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/weight_model.dart';
import '../repositories/weight_repository.dart';

class WeightController extends GetxController {
  final repo = WeightRepository();
  final isLoading = false.obs;
  final weights = <WeightEntry>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllWeights();
  }

  void fetchAllWeights() async {
    isLoading.value = true;
    try {
      final data = await repo.getAllWeights();
      weights.assignAll(data.reversed.toList());
    } catch (e, stack) {
      print('[WeightController] Lỗi khi fetch dữ liệu: $e');
      print(stack);
      Get.snackbar('Lỗi', 'Không thể tải dữ liệu cân nặng.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addWeight(double weight) async {
    isLoading.value = true;
    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final result = await repo.addWeight(today, weight);

      if (result != null) {
        weights.insert(0, result);
        Get.snackbar('Thành công', 'Đã thêm cân nặng!');
      } else {
        print('[WeightController] Lỗi: API trả về null khi thêm cân nặng.');
        Get.snackbar('Lỗi', 'Không thể thêm dữ liệu cân nặng.');
      }
    } catch (e, stack) {
      print('[WeightController] Lỗi Exception khi gọi API thêm cân nặng: $e');
      print(stack);

      // Nếu repo trả về Map có statusCode + body thì log chi tiết
      if (e is Map && e.containsKey('statusCode') && e.containsKey('body')) {
        print('[API] Status Code: ${e['statusCode']}');
        print('[API] Response Body: ${e['body']}');
      }

      Get.snackbar('Lỗi', 'Không thể thêm dữ liệu cân nặng.');
    } finally {
      isLoading.value = false;
    }
  }
}
