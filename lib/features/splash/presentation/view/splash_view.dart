import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // App Icon
                SizedBox(
                  child: SvgPicture.asset(
                    'assets/logo/logo.svg',
                    width: 50,
                    height: 50,
                  ),
                ),
                const Center(
                    // ... (your icon widget)
                    ),
                const SizedBox(height: 10),
                const Text(
                  'Vignette...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                // Circular Progress Indicator
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  strokeWidth: 4,
                ),
                const SizedBox(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }
}
