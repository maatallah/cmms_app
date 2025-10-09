import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionManager {
  static const _sessionKey = 'session';

  /// ✅ Save current session as JSON string
  Future<void> saveSession(Session session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, session.toJson().toString());
  }

  /// ✅ Restore saved session if exists
  Future<Session?> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_sessionKey);
    if (jsonString == null) return null;

    try {
      return Session.fromJson(Supabase.instance.client.auth.recoverSession(jsonString).data!.toJson());
    } catch (e) {
      return null;
    }
  }

  /// ✅ Clear saved session on logout
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }
}
