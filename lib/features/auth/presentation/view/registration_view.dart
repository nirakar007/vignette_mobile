import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/register/register_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  // Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Country list
  final List<String> countries = [
    'Nepal',
    'India',
    'United States',
    'United Kingdom',
    'Australia',
    'Canada',
    'Germany',
    'France',
    'China',
    'Japan',
  ];

  // Field focus flags
  bool isFullNameEmpty = false;
  bool isEmailEmpty = false;
  bool isCountryEmpty = false;
  bool isPasswordEmpty = false;
  bool isConfirmPasswordEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nirakar"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Registration Successful',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushReplacementNamed(context, "/login");
            } else if (!state.isLoading && !state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Registration Failed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/logo/logo.svg',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      "Vignette",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),

                    const Text("Sign Up"),
                    const SizedBox(height: 16),

                    // Input fields
                    _buildTextField(
                        fullNameController, 'Enter full name', isFullNameEmpty),
                    const SizedBox(height: 16),
                    _buildTextField(
                        emailController, 'Enter email', isEmailEmpty),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                        countryController, 'Select country', isCountryEmpty),
                    const SizedBox(height: 16),
                    _buildTextField(
                        passwordController, 'Enter password', isPasswordEmpty,
                        obscureText: true),
                    const SizedBox(height: 16),
                    _buildTextField(confirmPasswordController,
                        'Confirm password', isConfirmPasswordEmpty,
                        obscureText: true),
                    const SizedBox(height: 16),

                    // Register button
                    ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              setState(() {
                                isFullNameEmpty =
                                    fullNameController.text.trim().isEmpty;
                                isEmailEmpty =
                                    emailController.text.trim().isEmpty;
                                isCountryEmpty =
                                    countryController.text.trim().isEmpty;
                                isPasswordEmpty =
                                    passwordController.text.trim().isEmpty;
                                isConfirmPasswordEmpty =
                                    confirmPasswordController.text
                                        .trim()
                                        .isEmpty;
                              });

                              if (isFullNameEmpty ||
                                  isEmailEmpty ||
                                  isCountryEmpty ||
                                  isPasswordEmpty ||
                                  isConfirmPasswordEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'All fields must be filled.',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              context.read<RegisterBloc>().add(
                                    RegisterUser(
                                      email: emailController.text.trim(),
                                      username: fullNameController.text.trim(),
                                      password: passwordController.text.trim(),
                                      confirmPassword:
                                          confirmPasswordController.text.trim(),
                                    ),
                                  );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: state.isLoading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text('Register'),
                    ),
                  ],
                ),
              ),
            );
          },
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

  Widget _buildDropdownField(
      TextEditingController controller, String hintText, bool isEmpty) {
    return DropdownButtonFormField<String>(
      value: controller.text.isNotEmpty ? controller.text : null,
      onChanged: (value) {
        setState(() {
          controller.text = value ?? '';
        });
      },
      items: countries.map((country) {
        return DropdownMenuItem(
          value: country,
          child: Text(country),
        );
      }).toList(),
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: isEmpty ? Colors.red[100] : Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
