import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false; // To manage loading state
  bool termsAgreed = false; // To track terms agreement

  // Function to show a SnackBar
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

  // Simulate the registration process
  Future<void> register(String email, String password, String confirmPassword) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || !termsAgreed) {
      showSnackbar("All fields must be filled and terms must be agreed.", Colors.red);
      return;
    }

    if (password != confirmPassword) {
      showSnackbar("Passwords do not match.", Colors.red);
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    showSnackbar("Registration Successful", Colors.green);
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: SvgPicture.asset(
        //   'assets/logo/logo_vignette.svg',
        // ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Heading Text
                const Text(
                  "Create an account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Email Field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.lightGreen),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.lightGreen),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 20),

                // Biometric Registration Section
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.fingerprint,
                        size: 50,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        showSnackbar("Biometric Registration Tapped!", Colors.blue);
                      },
                    ),
                    const Text(
                      'Register biometrics',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Terms & Conditions Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: termsAgreed,
                      onChanged: (value) {
                        setState(() {
                          termsAgreed = value ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        "I agree to the terms and conditions",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Register Button
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
                  onPressed: isLoading
                      ? null
                      : () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final confirmPassword = confirmPasswordController.text.trim();

                    await register(email, password, confirmPassword);
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Already have an account? Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.lightGreen),
                      ),
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
