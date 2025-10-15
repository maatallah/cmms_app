
class User {
  final String id;
  final String? name;
  final String? email;
  final String? role;
  final String? status;
  final String? unit;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    this.name,
    this.email,
    this.role,
    this.status,
    this.unit,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        role: json['role'],
        status: json['status'],
        unit: json['unit'],
        phone: json['phone'],
        createdAt:
            json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
        updatedAt:
            json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'status': status,
        'unit': unit,
        'phone': phone,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
