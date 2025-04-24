import 'package:get/get.dart';
import '../models/appointment_model.dart';
import '../models/doctor_model.dart';
import '../repositories/appointment_repository.dart';
import '../repositories/doctor_repository.dart';
import '../services/api_service.dart';
import 'dart:convert';

class AppointmentController extends GetxController {
  final isLoading = false.obs;
  final doctors = <Doctor>[].obs;
  final selectedDoctor = Rxn<Doctor>();
  final selectedDate = Rxn<DateTime>();
  final selectedTime = RxnString();
  var type = 'offline'.obs;
  final appointments = <Appointment>[].obs;

  final AppointmentRepository _repo = AppointmentRepository();

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
        selectedDate.value == null ||
        selectedTime.value == null) {
      Get.snackbar('Thiếu thông tin', 'Vui lòng chọn bác sĩ, ngày và giờ khám');
      return;
    }

    final dateString =
        '${selectedDate.value!.year}-${selectedDate.value!.month.toString().padLeft(2, '0')}-${selectedDate.value!.day.toString().padLeft(2, '0')}';
    final timeString = selectedTime.value!;

    isLoading.value = true;
    try {
      final success = await _repo.bookAppointment(
        doctorId: selectedDoctor.value!.id,
        name: name,
        phone: phone,
        address: address,
        date: dateString,
        time: timeString,
        type: type.value,
        note: note,
      );

      if (success) {
        Get.back();
        Get.snackbar('Thành công', 'Đặt lịch thành công');
        await Future.delayed(Duration(seconds: 1));

        selectedDoctor.value = null;
        selectedDate.value = null;
        selectedTime.value = null;
      } else {
        Get.snackbar('Lỗi', 'Không thể đặt lịch. Vui lòng thử lại');
      }
    } catch (e) {
      print('[AppointmentController] Exception: $e');
      Get.snackbar('Lỗi', 'Đặt lịch thất bại. Vui lòng kiểm tra kết nối.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserAppointments() async {
    isLoading.value = true;
    try {
      final result = await _repo.getUserAppointments();
      appointments.assignAll(result);
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
