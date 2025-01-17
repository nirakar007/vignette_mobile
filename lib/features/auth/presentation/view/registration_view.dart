import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignette__mobile/app/widget/showMySnackbar.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/register/register_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  // Field focus flags
  bool isEmailEmpty = false;
  bool isUsernameEmpty = false;
  bool isPasswordEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
          return const Text("Register User");
        }),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/logo/logo.svg',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Welcome To Vignette",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 16),

                  // Input fields
                  _buildTextField(
                      _emailController, 'Enter email', isEmailEmpty),
                  const SizedBox(height: 16),
                  _buildTextField(
                      _usernameController, 'Enter username', isUsernameEmpty),
                  const SizedBox(height: 16),
                  _buildTextField(
                      _passwordController, 'Enter password', isPasswordEmpty,
                      obscureText: true),
                  const SizedBox(height: 16),

                  // Checkbox for email updates
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {
                          // Handle checkbox state
                        },
                      ),
                      const Text('Send email of latest updates'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Biometric login setup
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle biometric setup
                      showSnackbar(
                          context: context,
                          message: "Biometric option pressed!",
                          color: Colors.grey);
                    },
                    icon: const Icon(Icons.fingerprint, size: 24),
                    label: const Text('Set up biometric login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Register button
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        context.read<RegisterBloc>().add(
                              RegisterUser(
                                  email: _emailController.text,
                                  username: _usernameController.text,
                                  password: _passwordController.text),
                            );

                        showSnackbar(
                            context: context,
                            message: "Registered Successfully!",
                            color: Colors.green);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Text("Register"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hintText, bool isEmpty,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: (_) {
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: isEmpty ? Colors.red[100] : Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
}
