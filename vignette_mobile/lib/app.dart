import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vignette_mobile/view/login_screen.dart';
import 'package:vignette_mobile/view/registration_screen.dart';
import 'package:vignette_mobile/viewmodel/login_viewmodel.dart';
import 'package:vignette_mobile/viewmodel/registration_viewmodel.dart';

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
        debugShowCheckedModeBanner: false,
        initialRoute: '/register',
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegistrationScreen(),
        },
      ),
    );
  }
}
