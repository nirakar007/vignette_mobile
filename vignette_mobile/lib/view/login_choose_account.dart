import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';



class LoginOptionsScreen extends StatelessWidget {
  const LoginOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title:  SvgPicture.asset(
        //   'assets/logo/logo_vignette.svg', // Replace with your app logo
        //
        // ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            // Welcome Text
            const Text(
              'Vignette',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Choose account text
            const Text(
              'Choose an account to Login with',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),

            // Account selection options (can be images or icons)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First account option (image or icon)
                GestureDetector(
                  onTap: () {
                    // Navigate to login with selected account
                  },
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/account1.png'), // Replace with your image
                  ),
                ),
                const SizedBox(width: 30),
                // Second account option (image or icon)
                GestureDetector(
                  onTap: () {
                    // Navigate to login with selected account
                  },
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/account2.png'), // Replace with your image
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),

            // Biometric login option (Fingerprint)
            GestureDetector(
              onTap: () {
                // Handle biometric login
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Biometric Login Tapped!')),
                );
              },
              child: const Column(
                children: [
                  Icon(
                    Icons.fingerprint,
                    size: 50,
                    color: Colors.black87,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Use Biometrics to Login',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.black87,
              ),

              onPressed: () { Navigator.pushNamed(context, '/main'); },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
