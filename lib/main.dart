import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:irish_coffe/core/public_managers/notification_manager.dart';
import 'package:irish_coffe/firebase_options.dart';
import 'views/authantication/landing_view/view/landing_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationManager.instance.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const LandingView(),
    );
  }
}
