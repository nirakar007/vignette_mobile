import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignette__mobile/features/auth/presentation/view/registration_view.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/login/login_bloc.dart';
// ... other imports

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final double _mobileBreakpoint = 600; // Adjust this based on your needs

  @override
  Widget build(BuildContext context) {
    final bool isTablet =
        MediaQuery.of(context).size.width >= _mobileBreakpoint;
    final double logoSize = isTablet ? 150.0 : 100.0;
    final double horizontalPadding = isTablet ? 100.0 : 30.0;
    final double maxFormWidth = isTablet ? 500.0 : double.infinity;

    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {/* Keep existing listener */},
        builder: (context, state) {
          return ResponsiveLayout(
            mobile: _buildMobileLayout(
                context, state, logoSize, horizontalPadding, maxFormWidth),
            tablet: _buildTabletLayout(
                context, state, logoSize, horizontalPadding, maxFormWidth),
          );
        },
      ),
    );
  }

  Widget _buildBaseLayout(
    BuildContext context,
    LoginState state,
    double logoSize,
    double horizontalPadding,
    double maxFormWidth,
  ) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0x00dbfdff),
            Colors.white,
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
              maxWidth: maxFormWidth,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeaderSection(context, logoSize),
                    const SizedBox(height: 40),
                    _buildInputFields(context),
                    const SizedBox(height: 28),
                    _buildLoginButton(context, state),
                    const SizedBox(height: 24),
                    _buildRegisterSection(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    LoginState state,
    double logoSize,
    double horizontalPadding,
    double maxFormWidth,
  ) {
    return _buildBaseLayout(
        context, state, logoSize, horizontalPadding, maxFormWidth);
  }

  Widget _buildTabletLayout(
    BuildContext context,
    LoginState state,
    double logoSize,
    double horizontalPadding,
    double maxFormWidth,
  ) {
    return Center(
      child: SizedBox(
        width: 800, // Max width for tablet layout
        child: _buildBaseLayout(
            context, state, logoSize, horizontalPadding, maxFormWidth),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, double logoSize) {
    return Column(
      children: [
        Hero(
          tag: 'app-logo',
          child: SvgPicture.asset(
            'assets/logo/logo.svg',
            width: logoSize,
            height: logoSize,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Welcome Back',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.06,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
        ),
      ],
    );
  }

  Widget _buildInputFields(BuildContext context) {
    final bool isTablet =
        MediaQuery.of(context).size.width >= _mobileBreakpoint;

    return Column(
      children: [
        TextFormField(
          controller: _usernameController,
          decoration: _buildInputDecoration(
            context,
            label: "Username",
            icon: Icons.person_outline,
            isTablet: isTablet,
          ),
          validator: (value) => value!.isEmpty ? 'Please enter username' : null,
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: _buildInputDecoration(
            context,
            label: "Password",
            icon: Icons.lock_outline,
            isTablet: isTablet,
          ).copyWith(
            suffixIcon: IconButton(
              icon: Icon(Icons.visibility_off, color: Colors.grey[400]),
              onPressed: () {}, // Add password visibility toggle
            ),
          ),
          validator: (value) => value!.isEmpty ? 'Please enter password' : null,
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isTablet,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey[400]),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(
        vertical: isTablet ? 20 : 16,
        horizontal: 16,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, LoginState state) {
    final bool isTablet =
        MediaQuery.of(context).size.width >= _mobileBreakpoint;

    return ElevatedButton(
      onPressed: state.isLoading
          ? null
          : () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(
                      LoginUserEvent(
                        context: context,
                        username: _usernameController.text,
                        password: _passwordController.text,
                      ),
                    );
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: state.isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(
              "Login",
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w600,
              ),
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
          "Don't have an account?",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: isTablet ? 16 : 14,
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<LoginBloc>().add(
                  NavigateRegisterScreenEvent(
                    destination: const RegistrationScreen(),
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
            "Register",
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

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 600) {
      // Adjust breakpoint as needed
      return tablet;
    } else {
      return mobile;
    }
  }
}
