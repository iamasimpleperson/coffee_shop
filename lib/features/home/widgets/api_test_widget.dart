import 'package:flutter/material.dart';
import 'package:coffee_shop/services/api_service.dart';

class ApiTestWidget extends StatefulWidget {
  const ApiTestWidget({super.key});

  @override
  State<ApiTestWidget> createState() => _ApiTestWidgetState();
}

class _ApiTestWidgetState extends State<ApiTestWidget> {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String _responseLog = 'Press a button to test the API...';

  void _log(String message) {
    setState(() {
      _responseLog = message;
      _isLoading = false;
    });
  }

  Future<void> _testGetStatus() async {
    setState(() => _isLoading = true);
    final status = await _apiService.fetchStatus();
    if (status != null) {
      _log('✅ GET Status Success:\nMessage: ${status.message}');
    } else {
      _log('❌ GET Status Failed');
    }
  }

  Future<void> _testGetUser() async {
    setState(() => _isLoading = true);
    final user = await _apiService.fetchUser();
    if (user != null) {
      _log(
        '✅ GET User Success:\nEmail: ${user.email}\nAuth: ${user.authProvider}',
      );
    } else {
      _log('❌ GET User Failed (Check if user ID 1 exists)');
    }
  }

  Future<void> _testPostUser() async {
    setState(() => _isLoading = true);
    final user = await _apiService.createUser(
      'test${DateTime.now().millisecondsSinceEpoch}@example.com',
      'password123',
      'email',
      false,
    );
    if (user != null) {
      _log(
        '✅ POST User Success:\nCreated ID: ${user.id}\nEmail: ${user.email}',
      );
    } else {
      _log('❌ POST User Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.api, color: Colors.blue),
              const SizedBox(width: 8),
              const Text(
                'API Playground Box',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (_isLoading)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Action Buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _testGetStatus,
                icon: const Icon(Icons.cloud_download, size: 16),
                label: const Text('GET Status'),
              ),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _testGetUser,
                icon: const Icon(Icons.person_search, size: 16),
                label: const Text('GET User'),
              ),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _testPostUser,
                icon: const Icon(Icons.person_add, size: 16),
                label: const Text('POST User'),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Text(
            'Response Log:',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 8),

          // Response Log Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _responseLog,
              style: const TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
