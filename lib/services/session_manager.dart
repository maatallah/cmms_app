import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_response.dart';

class SessionManager {
  static const String _sessionKey = 'user_session';

  /// Save session data locally
  Future<void> saveSession(AuthResponse session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, session.toJson());
  }

  /// Load session data
  Future<AuthResponse?> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionString = prefs.getString(_sessionKey);
    if (sessionString == null) return null;
    return AuthResponse.fromJson(sessionString);
  }

  /// Clear saved session
  Future<void> clearSavedSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }
}
