import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReturningLoginScreen extends StatelessWidget {
  const ReturningLoginScreen({super.key});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLoginComplete', false);
    Navigator.pushReplacementNamed(context, "/login");
  }

  Future<void> switchAccount(BuildContext context) async {
    Navigator.pushReplacementNamed(context, "/register");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Back!"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Welcome back to Vignette!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => switchAccount(context),
            child: const Text("Switch Account"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => logout(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
