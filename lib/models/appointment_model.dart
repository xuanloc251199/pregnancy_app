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
  final int doctorId;

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
    required this.doctorId,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        address: json['address'],
        date: json['date'],
        time: json['time'],
        type: json['type'],
        note: json['note'] ?? '',
        status: json['status'],
        doctorId: json['doctor_id'],
      );
}
