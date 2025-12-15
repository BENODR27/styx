import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';

// lib/features/auth/services/auth_service.dart
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/mock_api_client.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(
      String employeeCode,
      String secretCode,
      ) async {
    // Call the mock API
    return await MockApiClient.post(
      ApiEndpoints.login,
      {
        'employee_code': employeeCode,
        'secret_code': secretCode,
      },
    );
  }
}
