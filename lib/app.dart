import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vignette__mobile/core/app_theme/app_theme.dart';
import 'package:vignette__mobile/screens/dashboard.dart';
import 'package:vignette__mobile/screens/login_screen.dart';
import 'package:vignette__mobile/screens/onboarding_screen.dart'; // Add this import
import 'package:vignette__mobile/screens/registration_screen.dart';
import 'package:vignette__mobile/screens/returning_login_screen.dart';
import 'package:vignette__mobile/viewmodel/login_viewmodel.dart';
import 'package:vignette__mobile/viewmodel/registration_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> determineInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    final isFirstLoginComplete = prefs.getBool('isFirstLoginComplete') ?? false;

    if (!hasSeenOnboarding) {
      return '/onboarding';
    } else if (!isFirstLoginComplete) {
      return '/register';
    } else {
      return '/returning-login'; // Second login page for returning users
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: determineInitialRoute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
              home: Center(child: CircularProgressIndicator()));
        }

        final initialRoute = snapshot.data ?? '/register';

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LoginViewModel()),
            ChangeNotifierProvider(create: (_) => RegistrationViewModel()),
          ],
          child: MaterialApp(
            title: 'Vignette',
            theme: getApplicationTheme(),
            debugShowCheckedModeBanner: false,
            initialRoute: initialRoute,
            routes: {
              '/onboarding': (context) => OnboardingScreen(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegistrationScreen(),
              '/dashboard': (context) => const Dashboard(),
              '/returning-login': (context) => const ReturningLoginScreen(),
            },
          ),
        );
      },
    );
  }
}
