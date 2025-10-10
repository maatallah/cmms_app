import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/login_screen.dart';
import '../screens/main_shell.dart';

class SessionManager extends StatefulWidget {
  const SessionManager({super.key, this.initialSession});

  final Session? initialSession;

  @override
  State<SessionManager> createState() => _SessionManagerState();

  /// 🔹 Save a Supabase session locally
  static Future<void> saveSession(Session session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session', jsonEncode(session.toJson()));
  }

  /// 🔹 Restore session from SharedPreferences
  static Future<Session?> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('session');
    if (jsonString == null) return null;

    try {
      final sessionMap = jsonDecode(jsonString);
      final response = await Supabase.instance.client.auth.recoverSession(jsonString);
      return response.session;
    } catch (e) {
      debugPrint("Erreur lors de la restauration de session : $e");
      return null;
    }
  }

  /// 🔹 Clear saved session
  static Future<void> clearSavedSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session');
  }
}

class _SessionManagerState extends State<SessionManager> {
  Session? _session;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initSession();
  }

  Future<void> _initSession() async {
    if (widget.initialSession != null) {
      _session = widget.initialSession;
    } else {
      _session = await SessionManager.restoreSession();
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return _session == null
        ? const LoginScreen()
        : const MainShell();
  }
}
