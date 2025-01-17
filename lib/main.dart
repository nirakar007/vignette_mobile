import 'package:flutter/material.dart';
import 'package:vignette__mobile/app/di/di.dart';
import 'package:vignette__mobile/core/network/hive_service.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  await initDependencies();

  runApp(
    const MyApp(),
  );
}
