import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffee_shop/models/user_model.dart';
import 'package:coffee_shop/services/api_service.dart';

class AuthState {
  final UserModel? currentUser;
  final bool isAuthenticated;
  final String? userName;

  AuthState({this.currentUser, this.isAuthenticated = false, this.userName});

  AuthState copyWith({UserModel? currentUser, bool? isAuthenticated, String? userName}) {
    return AuthState(
      currentUser: currentUser ?? this.currentUser,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userName: userName ?? this.userName,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    final userEmail = prefs.getString('user_email');
    final userName = userEmail != null ? prefs.getString('user_name_$userEmail') : null;
    final registeredDateStr = prefs.getString('user_registered_date');
    DateTime? registeredDate;
    if (registeredDateStr != null) {
      registeredDate = DateTime.tryParse(registeredDateStr);
    }

    if (userId != null && userEmail != null) {
      final user = UserModel(
        id: int.parse(userId),
        email: userEmail,
        authProvider: 'email',
        isGuest: false,
      );
      state = AuthState(currentUser: user, isAuthenticated: true, userName: userName);
    }
  }

  Future<void> login(String email, String password) async {
    final apiService = ApiService();
    final user = await apiService.login(email, password);

    if (user == null) {
      throw Exception('Invalid credentials or network error.');
    }

    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('user_name_$email');
    state = AuthState(currentUser: user, isAuthenticated: true, userName: savedName);

    await prefs.setString('user_id', user.id.toString());
    await prefs.setString('user_email', user.email);
    await prefs.setString('user_registered_date', DateTime.now().toIso8601String());
  }

  Future<void> register(String name, String email, String password) async {
    final apiService = ApiService();
    // Name is collected in UI but not supported by backend schema
    final user = await apiService.createUser(email, password, 'email', false);

    if (user == null) {
      throw Exception('Failed to register user.');
    }

    state = AuthState(currentUser: user, isAuthenticated: true, userName: name);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', user.id.toString());
    await prefs.setString('user_name_$email', name);
    await prefs.setString('user_email', user.email);
    await prefs.setString('user_registered_date', DateTime.now().toIso8601String());
  }

  Future<void> updateProfile(String name, String email) async {
    if (state.currentUser != null) {
      final user = UserModel(
        id: state.currentUser!.id,
        email: email,
        authProvider: 'email',
        isGuest: false,
      );
      state = state.copyWith(currentUser: user, userName: name);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name_$email', name);
      await prefs.setString('user_email', email);
    }
  }

  Future<void> logout() async {
    state = AuthState();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    // We intentionally DO NOT remove the user_name_$email here so that if the user logs back in on this device, their name is remembered.
    await prefs.remove('user_email');
    await prefs.remove('user_registered_date');
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
