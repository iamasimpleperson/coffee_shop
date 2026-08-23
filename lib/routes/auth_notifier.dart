import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffee_shop/models/user_model.dart';

class AuthNotifier extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
  UserModel? get currentUser => _currentUser;

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
      _currentUser = UserModel(id: userId, name: userName, email: userEmail, registeredDate: registeredDate);
      _isAuthenticated = true;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock user login
    final now = DateTime.now();
    _currentUser = UserModel(id: '1', name: 'Coffee Lover', email: email, registeredDate: now);
    _isAuthenticated = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', _currentUser!.id);
    await prefs.setString('user_name', _currentUser!.name);
    await prefs.setString('user_email', _currentUser!.email);
    await prefs.setString('user_registered_date', now.toIso8601String());

    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock user registration
    final now = DateTime.now();
    _currentUser = UserModel(id: '2', name: name, email: email, registeredDate: now);
    _isAuthenticated = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', _currentUser!.id);
    await prefs.setString('user_name', _currentUser!.name);
    await prefs.setString('user_email', _currentUser!.email);
    await prefs.setString('user_registered_date', now.toIso8601String());

    notifyListeners();
  }

  Future<void> updateProfile(String name, String email) async {
    if (_currentUser != null) {
      _currentUser = UserModel(id: _currentUser!.id, name: name, email: email, registeredDate: _currentUser!.registeredDate);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name);
      await prefs.setString('user_email', email);

      notifyListeners();
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _isAuthenticated = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.remove('user_registered_date');

    notifyListeners();
  }
}

// Global instance for simple access
final authNotifier = AuthNotifier();
