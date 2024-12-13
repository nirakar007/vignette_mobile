import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vignette__mobile/common/snackBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? usernameError;
  String? passwordError;

  final String predefinedUsername = "user123";
  final String predefinedPassword = "pass123";

  void validateAndLogin(BuildContext context) {
    setState(() {
      if (usernameController.text.isEmpty) {
        usernameError = 'Username cannot be empty';
      } else if (usernameController.text != predefinedUsername) {
        usernameError = 'Username is incorrect';
      } else {
        usernameError = null;
      }

      if (passwordController.text.isEmpty) {
        passwordError = 'Password cannot be empty';
      } else if (passwordController.text != predefinedPassword) {
        passwordError = 'Password is incorrect';
      } else {
        passwordError = null;
      }
    });

    if (usernameError == null && passwordError == null) {
      Navigator.pushNamed(context, "/dashboard");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nirakar"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image.asset(
                //   'assets/images/login_bg.png',
                //   fit: BoxFit.fill,
                // ),
                // Logo
                SafeArea(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/logo/logo.svg',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Welcome to',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        'Vignette',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Login Title
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Username Input
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    label: const Text("Enter Username"),
                    errorText: usernameError,
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 16),

                // Password Input
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: const Text('Enter password'),
                    errorText: passwordError,
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 16),

                // Register & Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("not a user?"),
                    TextButton(
                      onPressed: () {
                        showMySnackBar(
                            context: context,
                            message: "Going to registration page..");
                        Navigator.pushNamed(context, "/register");
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Biometric Login
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle biometric login
                      },
                      icon: const Icon(Icons.fingerprint),
                      iconSize: 48,
                      color: Colors.black,
                    ),
                    const Text(
                      'Use biometrics to login',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => validateAndLogin(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
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
