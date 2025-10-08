import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'services/session_manager.dart';
import 'supabase_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSupabase();

  // ✅ Supabase auto-restores the session now.
  final session = Supabase.instance.client.auth.currentSession;

  runApp(CMMSApp(initialSession: session));
}

class CMMSApp extends StatelessWidget {
  final Session? initialSession;
  const CMMSApp({super.key, this.initialSession});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CMMS App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SessionManager(initialSession: initialSession),
      debugShowCheckedModeBanner: false,
    );
  }
}
