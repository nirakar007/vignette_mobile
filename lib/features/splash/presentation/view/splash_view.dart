import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignette__mobile/features/splash/presentation/view_model/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  final SplashCubit splashCubit;

  const SplashScreen({super.key, required this.splashCubit});

  @override
  Widget build(BuildContext context) {
    splashCubit.init(context); // Call the Cubit's init method
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // App Icon
          Center(
            child: Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Flexible(
                child: SvgPicture.asset(
                  'assets/images/home_screen/prem_ad.svg',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
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
            strokeWidth: 3,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
