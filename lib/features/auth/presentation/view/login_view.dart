import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignette__mobile/features/auth/presentation/view/registration_view.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:vignette__mobile/features/home/presentation/view/home_view.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _gap = const SizedBox(height: 16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nirakar')),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (!state.isLoading && !state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Invalid Credentials"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    const SizedBox(height: 32),
                    TextFormField(
                      key: const ValueKey('username'),
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    TextFormField(
                      key: const ValueKey('password'),
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {
                            // Handle checkbox state
                          },
                        ),
                        const Text('Keep me logged in'),
                      ],
                    ),
                    _gap,
                    Column(children: [
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
                    ]),
                    _gap,
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(LoginUserEvent(
                              context: context,
                              username: _usernameController.text,
                              password: _passwordController.text));
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
                      child: state.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Login"),
                    ),
                    Column(
                      children: [
                        _gap,
                        const Text("Dont have an Account?"),
                        TextButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                  NavigateRegisterScreenEvent(
                                    context: context,
                                    destination: const RegistrationScreen(),
                                  ),
                                );
                          },
                          child: const Text(
                            "Register here",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
