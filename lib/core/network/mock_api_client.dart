// lib/core/network/mock_api_client.dart
import 'dart:async';

class MockApiClient {
  /// Simulate POST request
  static Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    // Example mock for login endpoint
    if (endpoint.contains('login')) {
      final employee = body['employee_code'];
      final secret = body['secret_code'];

      // Simple mock logic: valid credentials
      if (employee == 'EMP001' && secret == '1234') {
        return {
          'status': 'success',
          'token': 'mocked_jwt_token_123456',
          'employee': employee,
        };
      } else {
        // Simulate failed login
        throw Exception('Invalid credentials');
      }
    }

    // Default fallback
    return {'status': 'ok'};
  }
}
