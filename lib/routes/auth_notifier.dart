import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffee_shop/models/user_model.dart';

class AuthState {
  final UserModel? currentUser;
  final bool isAuthenticated;

  AuthState({this.currentUser, this.isAuthenticated = false});

  AuthState copyWith({UserModel? currentUser, bool? isAuthenticated}) {
    return AuthState(
      currentUser: currentUser ?? this.currentUser,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
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
    final userName = prefs.getString('user_name');
    final userEmail = prefs.getString('user_email');
    final registeredDateStr = prefs.getString('user_registered_date');
    DateTime? registeredDate;
    if (registeredDateStr != null) {
      registeredDate = DateTime.tryParse(registeredDateStr);
    }

    if (userId != null && userName != null && userEmail != null) {
      final user = UserModel(id: userId, name: userName, email: userEmail, registeredDate: registeredDate);
      state = AuthState(currentUser: user, isAuthenticated: true);
    }
  }

  Future<void> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock user login
    final now = DateTime.now();
    final user = UserModel(id: '1', name: 'Coffee Lover', email: email, registeredDate: now);
    state = AuthState(currentUser: user, isAuthenticated: true);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', user.id);
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_email', user.email);
    await prefs.setString('user_registered_date', now.toIso8601String());
  }

  Future<void> register(String name, String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock user registration
    final now = DateTime.now();
    final user = UserModel(id: '2', name: name, email: email, registeredDate: now);
    state = AuthState(currentUser: user, isAuthenticated: true);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', user.id);
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_email', user.email);
    await prefs.setString('user_registered_date', now.toIso8601String());
  }

  Future<void> updateProfile(String name, String email) async {
    if (state.currentUser != null) {
      final user = UserModel(id: state.currentUser!.id, name: name, email: email, registeredDate: state.currentUser!.registeredDate);
      state = state.copyWith(currentUser: user);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name);
      await prefs.setString('user_email', email);
    }
  }

  Future<void> logout() async {
    state = AuthState();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.remove('user_registered_date');
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
