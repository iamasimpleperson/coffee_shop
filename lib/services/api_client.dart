import 'dart:convert';
import 'package:http/http.dart' as http;

/// A generic API client that handles all standard HTTP requests.
/// All specific services (UserService, CoffeeService, etc.) should use this client.
class ApiClient {
  static const String baseUrl = 'https://coffee-maker-backend.onrender.com';

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    // 'Authorization': 'Bearer $_token', // Add token logic here later
  };

  /// GET request helper
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: _headers);
      return _processResponse(response);
    } catch (e) {
      print('GET Request Error ($endpoint): $e');
      return null;
    }
  }

  /// POST request helper
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      print('POST Request Error ($endpoint): $e');
      return null;
    }
  }

  /// PUT request helper
  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      print('PUT Request Error ($endpoint): $e');
      return null;
    }
  }

  /// DELETE request helper
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$endpoint'), headers: _headers);
      return _processResponse(response);
    } catch (e) {
      print('DELETE Request Error ($endpoint): $e');
      return null;
    }
  }

  /// Processes the HTTP response and handles status codes.
  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Decode JSON if it's a success
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      }
      return {'status': 'success'}; // Return empty map if body is empty
    } else {
      print('API Error: Status ${response.statusCode}, Body: ${response.body}');
      return null; // Return null on error so your services can handle it gracefully
    }
  }
}
