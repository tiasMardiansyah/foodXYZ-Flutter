import 'package:flutter/material.dart';
import 'package:food_xyz_project/app/auth/screens/login.screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:LoginScreen(),
    );
  }
}