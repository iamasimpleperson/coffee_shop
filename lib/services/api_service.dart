import 'package:coffee_shop/models/status_model.dart';
import 'package:coffee_shop/models/user_model.dart';
import 'package:coffee_shop/services/api_client.dart';

class ApiService {
  final ApiClient _client = ApiClient();

  /// GET request to fetch the backend status
  Future<StatusModel?> fetchStatus() async {
    final data = await _client.get('/');
    if (data != null) {
      return StatusModel.fromJson(data);
    }
    return null;
  }

  /// GET request to fetch a User
  Future<UserModel?> fetchUser() async {
    // NOTE: Replace '/api/v1/users/1' with your real backend endpoint logic
    final data = await _client.get('/api/v1/users/1');
    if (data != null) {
      return UserModel.fromJson(data);
    }
    return null;
  }

  /// POST request to login a User
  Future<UserModel?> login(String email, String password) async {
    final data = await _client.postForm('/api/v1/login/access-token', {
      'username': email, // OAuth2 specifies 'username'
      'password': password,
    });

    if (data != null && data['access_token'] != null) {
      _client.setToken(data['access_token']);
      
      // Now fetch the user data
      final userData = await _client.get('/api/v1/users/me');
      if (userData != null) {
        return UserModel.fromJson(userData);
      }
    } else if (data != null && data['detail'] != null) {
      throw Exception(data['detail'].toString());
    }
    return null;
  }

  /// POST request to create a User
  Future<UserModel?> createUser(
    String email,
    String password,
    String authProvider,
    bool isGuest,
  ) async {
    final data = await _client.post('/api/v1/users/', {
      'email': email,
      'password': password,
      'auth_provider': authProvider,
      'is_guest': isGuest,
    });

    if (data != null && data['detail'] == null) {
      return UserModel.fromJson(data);
    } else if (data != null && data['detail'] != null) {
      throw Exception(data['detail'].toString());
    }
    return null;
  }
}
