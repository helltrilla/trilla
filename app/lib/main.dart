import 'package:flutter/material.dart';
import 'package:app/layers/view/screens/onboarding.dart';
// import 'package:app/layers/view/screens/home.dart'; // Убираем или оставляем если нужно

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Delivery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC67C4E),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 34, 34, 34),
      ),
      home: const Onboarding(), // Стартуем с Onboarding
      debugShowCheckedModeBanner: false,
    );
  }
}