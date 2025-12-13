import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveLogin(String token, String employeeCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('auth_token', token);
    await prefs.setString('employee_code', employeeCode);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  static Future<String?> getEmployeeCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('employee_code');
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
