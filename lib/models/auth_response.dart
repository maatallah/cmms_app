import 'dart:convert';

class AuthResponse {
  final String token;
  final String username;

  AuthResponse({required this.token, required this.username});

  // Convert object to JSON string
  String toJson() => jsonEncode({
        'token': token,
        'username': username,
      });

  // Convert JSON string to object
  factory AuthResponse.fromJson(String jsonStr) {
    final Map<String, dynamic> data = jsonDecode(jsonStr);
    return AuthResponse(
      token: data['token'],
      username: data['username'],
    );
  }
}
