class Doctor {
  final int id;
  final String name;
  final String? avatar;
  final String email;
  final String phone;
  final String address;

  Doctor({
    required this.id,
    required this.name,
    this.avatar,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json['id'],
        name: json['name'],
        avatar: json['avatar'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
      );
}
