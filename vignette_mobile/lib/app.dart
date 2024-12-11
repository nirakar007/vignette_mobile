import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vignette_mobile/view/login_choose_account.dart';
import 'package:vignette_mobile/view/login_screen.dart';
import 'package:vignette_mobile/view/registration_screen.dart';
import 'package:vignette_mobile/viewmodel/login_viewmodel.dart';
import 'package:vignette_mobile/viewmodel/main_page.dart';
import 'package:vignette_mobile/viewmodel/registration_viewmodel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

      return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegistrationScreen(),
          '/main':(context) => const MainPage(),
          '/login_switch': (context) => const LoginOptionsScreen(),
        },
      );
  }
}
