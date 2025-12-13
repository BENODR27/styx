class LoginResponse {
  final String token;
  final String employeeCode;

  LoginResponse({
    required this.token,
    required this.employeeCode,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      employeeCode: json['employee_code'],
    );
  }
}
