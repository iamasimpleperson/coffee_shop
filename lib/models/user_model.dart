class UserModel {
  final String id;
  final String name;
  final String email;
  final DateTime? registeredDate;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.registeredDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      registeredDate: json['registeredDate'] != null ? DateTime.parse(json['registeredDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'registeredDate': registeredDate?.toIso8601String(),
    };
  }
}
