import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit_lite/init.dart' as init;
import 'package:app/layers/view/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await init.initMapkit(
      apiKey: '422e9589-580d-49bd-b0fc-a3c013dd9c1c',
    );
  } catch (e) {
    print('Error initializing mapkit: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Delivery',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 34, 34, 34),
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}