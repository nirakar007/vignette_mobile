import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecuredNotes extends StatefulWidget {
  const SecuredNotes({super.key});

  @override
  State<SecuredNotes> createState() => _SecuredNotesState();
}

class _SecuredNotesState extends State<SecuredNotes> {
  final TextEditingController _passwordController = TextEditingController();
  final String _correctPassword = "1234"; // Placeholder password
  bool _isAuthenticated = false;
  String? _errorMessage;

  void _authenticate() {
    setState(() {
      if (_passwordController.text == _correctPassword) {
        _isAuthenticated = true;
        _errorMessage = null;
      } else {
        _errorMessage = "Incorrect password. Please try again.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Secured Notes"),
      ),
      body: Center(
        child: _isAuthenticated
            ? const SecuredContent() // Replace with your actual secured content
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle biometric login
                      },
                      icon: const Icon(Icons.fingerprint),
                      iconSize: 100,
                      color: const Color(0xFF6875C8),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Or",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Enter Password to Access Notes",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], // Allows digits only
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: const OutlineInputBorder(),
                        errorText: _errorMessage,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _authenticate,
                      child: const Text("Unlock"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class SecuredContent extends StatelessWidget {
  const SecuredContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Welcome to your secured notes!",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

void main() => runApp(
      const MaterialApp(
        home: SecuredNotes(),
      ),
    );
