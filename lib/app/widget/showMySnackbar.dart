import 'package:flutter/material.dart';

showSnackbar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color ?? const Color(0x006875c8),
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
  ));
}
