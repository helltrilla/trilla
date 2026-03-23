import 'package:app/core/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:app/layers/view/screens/onboarding.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // во тут хуйня
    // надо
    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,
    //   тут вызываешь то поле AppRouter.router
    //   routerConfig: router,
    //   //+ theme выносим в core AppTheme и леоаем геттеры с dark и light темой
    //   theme: AppTheme.dart,
    // );
    return MaterialApp(
      title: 'Coffee Delivery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC67C4E)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 34, 34, 34),
      ),
      home: const Onboarding(), // Стартуем с Onboarding
      debugShowCheckedModeBanner: false,
    );
  }
}
