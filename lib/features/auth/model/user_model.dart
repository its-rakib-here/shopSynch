class User {
  final int id;
  final String name;
  final String phone;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
  });

  /// 🔥 FROM JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      role: json["role"] ?? "user",
    );
  }

  /// 🔥 TO JSON (optional but useful)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "role": role,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, phone: $phone, role: $role)';
  }
}