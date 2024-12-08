import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    // Function to show a floating SnackBar
    void showSnackbar(String message, Color color) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        // title: SvgPicture.asset(
        //   'assets/logo/logo_vignette.svg',
        //   semanticsLabel: 'App Logo',
        //   height: 32, // Adjust size as needed
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Section
                SvgPicture.asset(
                  'assets/logo/logo_vignette.svg',
                  height: 80,
                ),
                const SizedBox(height: 15),

                // Welcome Text
                const Text(
                  'Vignette',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 25),

                // Username/Email Field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter username/email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.lightGreen),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 16),

                // Password Field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Enter password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.lightGreen),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 10),

                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a user?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight:FontWeight.w800

                        ),

                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black87,
                  ),
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    // Validation: Ensure fields are not empty
                    if (email.isEmpty || password.isEmpty) {
                      showSnackbar('Please fill in all fields!', Colors.red);
                      return;
                    }

                    await loginViewModel.login(email, password);

                    // Check login result and show Snackbar accordingly
                    if (loginViewModel.isLoading) {
                      showSnackbar('Logging in...', Colors.blue);
                    } else if (loginViewModel.isLoading) {
                      showSnackbar('Login Successful!', Colors.green);
                    } else {
                      showSnackbar('Login Failed. Try again.', Colors.red);
                    }
                  },
                  child: loginViewModel.isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Separator Text
                const Text(
                  'or',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 10),

                // Biometric Section
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.fingerprint,
                        size: 50,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Biometric Login Tapped!')),
                        );
                      },
                    ),
                    const Text(
                      'Use biometrics to login',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
