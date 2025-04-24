import '../models/appointment_model.dart';
import '../services/api_service.dart';
import '../models/doctor_model.dart';
import 'dart:convert';

class AppointmentRepository {
  Future<List<Doctor>> getDoctors() async {
    final res = await ApiService.get('/doctors', useToken: true);
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body)['data'];
      return data.map((e) => Doctor.fromJson(e)).toList();
    }
    return [];
  }

  // Đặt lịch khám
  Future<bool> bookAppointment({
    required int doctorId,
    required String name,
    required String phone,
    required String address,
    required String date,
    required String time,
    required String type,
    String? note,
  }) async {
    final res = await ApiService.post('/appointments', useToken: true, body: {
      'doctor_id': doctorId,
      'name': name,
      'phone': phone,
      'address': address,
      'date': date,
      'time': time,
      'type': type,
      'note': note,
    });

    print('RESPONSE STATUS: ${res.statusCode}');
    print('RESPONSE BODY: ${res.body}');

    return res.statusCode == 200 || res.statusCode == 201;
  }

  Future<List<Appointment>> getUserAppointments() async {
    final res = await ApiService.get('/appointments/user', useToken: true);
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Appointment.fromJson(e)).toList();
    }
    return [];
  }
}
