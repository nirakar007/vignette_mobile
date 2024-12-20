import 'dart:math';

import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      fontFamily: 'Montserrat-Regular',
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.grey[100],
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        elevation: sqrt1_2,
        padding: const EdgeInsets.all(18),
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontFamily: 'Montserrat-Regular',
        ),
        backgroundColor: const Color(0xFF6875C8),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      )));
}
