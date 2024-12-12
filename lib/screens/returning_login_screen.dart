import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

class ReturningLoginScreen extends StatelessWidget {
  const ReturningLoginScreen({super.key});

  Future<void> authenticateUser(BuildContext context) async {
    final LocalAuthentication auth = LocalAuthentication();
    bool isAuthenticated = false;

    try {
      isAuthenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to login',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } catch (e) {
      print('Authentication error: $e');
    }

    if (isAuthenticated) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstLoginComplete', true);
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to Vignette",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => authenticateUser(context),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/p1.jpg'),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => authenticateUser(context),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/p2.jpg'),
              ),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: const Icon(Icons.fingerprint, size: 40),
              onPressed: () => authenticateUser(context),
            ),
          ],
        ),
      ),
    );
  }
}
