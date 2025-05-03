import 'package:recycle_mobile/screens/howToUse.dart';
import 'package:recycle_mobile/screens/landingScreen.dart';
import 'package:flutter/material.dart';
import 'package:recycle_mobile/screens/loginScreen.dart';
import 'package:recycle_mobile/screens/registerScreen.dart';
import 'package:recycle_mobile/screens/welcomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recycle Mobile App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const RegisterScreen(),
    );
  }
}