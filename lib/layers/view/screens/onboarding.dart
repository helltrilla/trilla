import 'package:app/layers/view/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    // во тут надо через stack делать типо накладываем друг на друга 1 слой фон другой текст
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Image.asset(
                  // ну и названия для всего нужно делать более понятными
                  'assets/photo/homepage.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Fall in Love with\nCoffee in Blissful\nDelight!',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Welcome to our cozy coffee corner, where\nevery cup is a delightful for you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 16,
                    height: 2,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Переход на главный экран
                    // ты используешь go_router надо так
                    // context.goNamed(AppRouterNames.home);
                    // вот это нахуй это дефодтная реализация
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC67C4E),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   body: Column(
    //     children: [
    //       Expanded(
    //         flex: 4,
    //         child: Image.asset(
    //           'assets/photo/homepage.png',
    //           width: double.infinity,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       Expanded(
    //         flex: 3,
    //         child: Container(
    //           color: Colors.black,
    //           child: SafeArea(
    //             child: Padding(
    //               padding: const EdgeInsets.all(0),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     'Fall in Love with\nCoffee in Blissful\nDelight!',
    //                     style: GoogleFonts.playfairDisplay(
    //                       fontSize: 32,
    //                       color: Colors.white,
    //                       fontWeight: FontWeight.bold,
    //                       height: 1.6,
    //                     ),
    //                   ),
    //                   const SizedBox(height: 12),
    //                   Text(
    //                     'Welcome to our cozy coffee corner, where\nevery cup is a delightful for you.',
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(
    //                       color: Colors.white.withValues(alpha: 0.7),
    //                       fontSize: 16,
    //                       height: 2,
    //                     ),
    //                   ),
    //                   const SizedBox(height: 30),
    //                   ElevatedButton(
    //                     onPressed: () {
    //                       // Переход на главный экран
    //                       Navigator.pushReplacement(
    //                         context,
    //                         MaterialPageRoute(
    //                           builder: (context) => const Home(),
    //                         ),
    //                       );
    //                     },
    //                     style: ElevatedButton.styleFrom(
    //                       backgroundColor: const Color(0xFFC67C4E),
    //                       foregroundColor: Colors.white,
    //                       minimumSize: const Size(double.infinity, 50),
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(15),
    //                       ),
    //                     ),
    //                     child: const Text('Get Started'),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
