class UserModel {
  final int id;
  final String email;
  final String authProvider;
  final bool isGuest;

  UserModel({
    required this.id,
    required this.email,
    required this.authProvider,
    required this.isGuest,
  });

  // Factory constructor to create a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? 0,
      email: json['email'] as String? ?? 'No email provided',

      // Notice how we map the JSON key 'auth_provider' to the Dart variable 'authProvider'
      authProvider: json['auth_provider'] as String? ?? 'Unknown',
      isGuest: json['is_guest'] as bool? ?? true,
    );
  }

  // Method to convert the UserModel back to a JSON map for POST requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'auth_provider': authProvider,
      'is_guest': isGuest,
    };
  }
}
