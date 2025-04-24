import 'package:get/get.dart';
import '../models/doctor_model.dart';
import '../repositories/doctor_repository.dart';
import '../services/api_service.dart';
import 'dart:convert';

class AppointmentController extends GetxController {
  final isLoading = false.obs;
  final doctors = <Doctor>[].obs;
  final selectedDoctor = Rxn<Doctor>();
  DateTime? selectedDate;
  String? selectedTime;
  var type = 'offline'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  void fetchDoctors() async {
    isLoading.value = true;
    try {
      final repo = DoctorRepository();
      final result = await repo.getDoctors();
      doctors.assignAll(result);
      if (result.isNotEmpty) selectedDoctor.value = result.first;
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void bookAppointment({
    required String name,
    required String phone,
    required String address,
    required String note,
  }) async {
    if (selectedDoctor.value == null ||
        selectedDate == null ||
        selectedTime == null) {
      Get.snackbar('Lỗi', 'Bạn cần nhập đủ thông tin và chọn bác sĩ/ngày/giờ');
      return;
    }
    isLoading.value = true;
    try {
      final response =
          await ApiService.post('/appointments', useToken: true, body: {
        'doctor_id': selectedDoctor.value!.id,
        'name': name,
        'phone': phone,
        'address': address,
        'date':
            '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}',
        'time': selectedTime,
        'type': type.value,
        'note': note,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Thành công', 'Đặt lịch thành công');
        Get.back();
      } else {
        final data = jsonDecode(response.body);
        Get.snackbar('Lỗi', data['message'] ?? 'Đặt lịch thất bại');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Lỗi kết nối');
    } finally {
      isLoading.value = false;
    }
  }
}
