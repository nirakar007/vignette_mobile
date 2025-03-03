import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vignette__mobile/features/auth/presentation/view/login_view.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/register/register_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _usernameController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');
  final _key = GlobalKey<FormState>();

  static File? _img;
  final double _mobileBreakpoint = 600; // Adjust this based on your needs

  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          print('HELLOUUU');
          context.read<RegisterBloc>().add(UploadImage(file: _img!));
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SvgPicture.asset('assets/logo/logo.svg',
                      width: 50, height: 50),
                  const SizedBox(height: 16),
                  const Text("Welcome To Vignette",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  const Text("Sign Up",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  _browseImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _browseImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        backgroundImage: _img != null
                            ? FileImage(_img!)
                            : const AssetImage('assets/images/profile.jpg')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(_emailController, 'Enter email'),
                  const SizedBox(height: 16),
                  _buildTextField(_usernameController, 'Enter username'),
                  const SizedBox(height: 16),
                  _buildTextField(_passwordController, 'Enter password',
                      obscureText: true),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(16),
                      ),
                      onPressed: () async {
                        final registerState =
                            context.read<RegisterBloc>().state;
                        final imageName = registerState.imageName;
                        print("VIEW MA IMAGE:: $_img");

                        context.read<RegisterBloc>().add(RegisterUser(
                            context: context,
                            email: _emailController.text,
                            username: _usernameController.text,
                            password: _passwordController.text,
                            profilePicture: imageName));
                      },
                      child: const Text("Register"),
                    ),
                  ),
                  _buildRegisterSection(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  Widget _buildRegisterSection(BuildContext context) {
    final bool isTablet =
        MediaQuery.of(context).size.width >= _mobileBreakpoint;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: isTablet ? 16 : 14,
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<RegisterBloc>().add(
                  NavigateLoginScreenEvent(
                    destination: LoginScreen(),
                    context: context,
                  ),
                );
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 16 : 8,
              vertical: isTablet ? 12 : 8,
            ),
          ),
          child: Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: isTablet ? 16 : 14,
            ),
          ),
        ),
      ],
    );
  }
}
