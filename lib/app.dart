import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vignette__mobile/screens/dashboard.dart';
import 'package:vignette__mobile/screens/login_screen.dart';
import 'package:vignette__mobile/screens/registration_screen.dart';
import 'package:vignette__mobile/viewmodel/login_viewmodel.dart';
import 'package:vignette__mobile/viewmodel/registration_viewmodel.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegistrationViewModel()), // Add this line
      ],
      child: MaterialApp(
        title: 'Vignette',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          primaryTextTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).primaryTextTheme),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/register',
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegistrationScreen(),
          '/dashboard': (context) => Dashboard(),
        },
      ),
    );
  }
}
