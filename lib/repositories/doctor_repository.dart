import '../models/doctor_model.dart';
import '../services/api_service.dart';
import 'dart:convert';

class DoctorRepository {
  Future<List<Doctor>> getDoctors() async {
    final response = await ApiService.get('/doctors', useToken: true);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Doctor.fromJson(e)).toList();
    } else {
      throw Exception('Lỗi lấy danh sách bác sĩ');
    }
  }
}
