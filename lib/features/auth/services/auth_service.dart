import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';

class AuthService {
  static Future<Map<String, dynamic>> login(
      String employeeCode,
      String secretCode,
      ) async {
    return await ApiClient.post(
      ApiEndpoints.login,
      {
        'employee_code': employeeCode,
        'secret_code': secretCode,
      },
    );
  }
}
