import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignette__mobile/app/di/di.dart';
import 'package:vignette__mobile/features/splash/presentation/view_model/splash_cubit.dart';
// ... other imports

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => getIt<SplashCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: context.read<SplashCubit>().init(context),
          builder: (context, snapshot) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                // App Icon
                Center(
                    // ... (your icon widget)
                    ),
                SizedBox(height: 16),
                Text(
                  'Vignette...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                // Circular Progress Indicator
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  strokeWidth: 3,
                ),
                SizedBox(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }
}
