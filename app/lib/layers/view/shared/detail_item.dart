import 'package:app/layers/view/screens/cart.dart';
import 'package:app/layers/view/screens/delivery.dart';
import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  final String coffeeName;
  final String? coffeePrice;
  final String? coffeeDescription;
  final String? coffeeImagePath;

  const DetailItem({
    super.key,
    required this.coffeeName,
    this.coffeePrice,
    this.coffeeDescription,
    this.coffeeImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 34, 34),
        title: Text(coffeeName, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Изображение кофе
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.brown[700],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  coffeeImagePath ?? 'assets/photo/',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.coffee, size: 80, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Название кофе
            Text(
              coffeeName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Описание
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                coffeeDescription ?? 'Delicious coffee made with love',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            // Цена
            Text(
              '\$${coffeePrice ?? '0.00'}',
              style: const TextStyle(
                color: Color.fromARGB(255, 201, 79, 43),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            // Кнопки
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Переход на DeliveryScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeliveryScreen(
                              coffeeName: coffeeName,
                              coffeePrice: coffeePrice ?? '0.00',
                              quantity: 1,
                              size: 'M',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 201, 79, 43),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Buy Now'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
