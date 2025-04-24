class Doctor {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? avatar;
  final String? avatarUrl;
  final String? role;
  final String? createdAt;
  final String? updatedAt;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.avatar,
    this.avatarUrl,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
        avatar: json['avatar'],
        avatarUrl: json['avatar_url'],
        role: json['role'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
}
