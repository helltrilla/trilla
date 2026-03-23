import 'package:flutter/material.dart';

class DetailItem  extends StatelessWidget {
  final String coffeeName;

  const DetailItem ({super.key, required this.coffeeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      title: Text(
        coffeeName, 
        style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.coffee,
        size: 100,
        color: Colors.brown,
        ),
        const SizedBox(height: 24,),
        Text(coffeeName, 
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold
        ),
        ),
        const SizedBox(height: 32,),
        ElevatedButton(onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )
        ), 
        child: const Text('Back to search'))
      ],
      ),
      ),
    );
  }
}