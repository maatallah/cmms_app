import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/login_screen.dart';
import '../screens/dashboard_screen.dart';

class SessionManager extends StatefulWidget {
  final Session? initialSession;
  const SessionManager({super.key, this.initialSession});

  @override
  State<SessionManager> createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager> {
  late final StreamSubscription<AuthState> _authSub;
  late Widget _child;

  @override
  void initState() {
    super.initState();
    _child = widget.initialSession == null
        ? const LoginScreen()
        : const DashboardScreen();

    _authSub =
        Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      setState(() {
        _child =
            session == null ? const LoginScreen() : const DashboardScreen();
      });
    });
  }

  @override
  void dispose() {
    _authSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}
