import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vignette_mobile/view/login_screen.dart';
import 'package:vignette_mobile/viewmodel/login_viewmodel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
        },
      ),
    );

  }
}
