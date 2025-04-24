import 'doctor_model.dart';

class Appointment {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String date;
  final String time;
  final String type;
  final String note;
  final String status;
  final Doctor? doctor;

  Appointment({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.date,
    required this.time,
    required this.type,
    required this.note,
    required this.status,
    this.doctor,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      name: json['name'],
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      type: json['type'] ?? '',
      note: json['note'] ?? '',
      status: json['status'] ?? '',
      doctor: json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null,
    );
  }
}
