import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool isLoading = false;
  String? errorMsg;

  Future<void> _signIn() async {
    setState(() => isLoading = true);
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );
    } on AuthException catch (e) {
      setState(() => errorMsg = e.message);
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _signUp() async {
    setState(() => isLoading = true);
    try {
      await Supabase.instance.client.auth.signUp(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );
    } on AuthException catch (e) {
      setState(() => errorMsg = e.message);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('CMMS Login', style: TextStyle(fontSize: 22)),
              const SizedBox(height: 20),
              TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
              const SizedBox(height: 10),
              TextField(controller: passCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
              const SizedBox(height: 20),
              if (errorMsg != null)
                Text(errorMsg!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              if (isLoading) const CircularProgressIndicator(),
              if (!isLoading)
                Column(
                  children: [
                    ElevatedButton(onPressed: _signIn, child: const Text('Login')),
                    TextButton(onPressed: _signUp, child: const Text('Sign Up')),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
