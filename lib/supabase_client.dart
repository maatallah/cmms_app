import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://tuzkizrsozpzxbctarfj.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR1emtpenJzb3pwenhiY3RhcmZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk3NTQ2NDcsImV4cCI6MjA3NTMzMDY0N30._Mkql-cnUVMKu3J-vbl_DrGJ948vsgPQatICaJwRDF0';

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
}
