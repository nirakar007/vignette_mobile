import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vignette__mobile/features/splash/presentation/view/splash_view.dart';
import 'package:vignette__mobile/features/splash/presentation/view_model/splash_cubit.dart';

void main() {
  runApp(const MyApp());
}

final getIt = GetIt.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vignette',
      home: BlocProvider<SplashCubit>(
        create: (_) => getIt<SplashCubit>(),
        child: const SplashScreen(),
      ),
    );
  }
}

// Future<String> determineInitialRoute() async {
//   final prefs = await SharedPreferences.getInstance();
//   final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
//   final isFirstLoginComplete = prefs.getBool('isFirstLoginComplete') ?? false;

//   if (!hasSeenOnboarding) {
//     return '/onboarding';
//   } else if (!isFirstLoginComplete) {
//     return '/register';
//   } else {
//     return '/returning-login'; // Second login page for returning users
//   }
// }

// @override
// Widget build(BuildContext context) {
//   return FutureBuilder<String>(
//     future: determineInitialRoute(),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const MaterialApp(
//             home: Center(child: CircularProgressIndicator()));
//       }

//       final initialRoute = snapshot.data ?? '/dashboard';

//       return MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (_) => LoginViewModel()),
//           ChangeNotifierProvider(create: (_) => RegistrationViewModel()),
//         ],
//         child: MaterialApp(
//           title: 'Vignette',
//           theme: getApplicationTheme(),
//           debugShowCheckedModeBanner: false,
//           initialRoute: initialRoute,
//           routes: {
//             '/onboarding': (context) => const OnboardingScreen(),
//             '/login': (context) => const LoginScreen(),
//             '/register': (context) => const RegistrationScreen(),
//             '/dashboard': (context) => const Dashboard(),
//             '/returning-login': (context) => const ReturningLoginScreen(),
//           },
//         ),
//       );
//     },
//   );
// }
