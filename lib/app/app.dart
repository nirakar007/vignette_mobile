import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vignette__mobile/features/splash/presentation/view/splash_view.dart';
import 'package:vignette__mobile/features/splash/presentation/view_model/splash_cubit.dart';



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
