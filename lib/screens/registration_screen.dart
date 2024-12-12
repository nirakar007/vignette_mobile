import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vignette__mobile/common/snackBar.dart';
import 'package:vignette__mobile/viewmodel/registration_viewmodel.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
    final registrationViewModel = Provider.of<RegistrationViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/registration_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),

            // Input fields
            _buildTextField(
                fullNameController, '*enter full name', isFullNameEmpty),
            const SizedBox(height: 16),
            _buildTextField(emailController, '*enter email', isEmailEmpty),
            const SizedBox(height: 16),
            _buildDropdownField(
                countryController, '*select country', isCountryEmpty),
            const SizedBox(height: 16),
            _buildTextField(
                passwordController, '*enter password', isPasswordEmpty,
                obscureText: true),
            const SizedBox(height: 16),
            _buildTextField(confirmPasswordController, '*confirm password',
                isConfirmPasswordEmpty,
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
                showMySnackBar(
                    context: context, message: "Biometric option pressed!");
              },
              icon: const Icon(Icons.fingerprint, size: 24),
              label: const Text('Set up biometric login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Register button
            ElevatedButton(
              onPressed: registrationViewModel.isLoading
                  ? null
                  : () async {
                      setState(() {
                        isFullNameEmpty =
                            fullNameController.text.trim().isEmpty;
                        isEmailEmpty = emailController.text.trim().isEmpty;
                        isCountryEmpty = countryController.text.trim().isEmpty;
                        isPasswordEmpty =
                            passwordController.text.trim().isEmpty;
                        isConfirmPasswordEmpty =
                            confirmPasswordController.text.trim().isEmpty;
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

                      try {
                        await registrationViewModel.register(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            confirmPasswordController.text.trim());
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
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: registrationViewModel.isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text('Register'),
            ),
          ],
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
