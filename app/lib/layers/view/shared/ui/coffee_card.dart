import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoffeeCard extends StatelessWidget {
  final String name;
  final String price;
  final String description;
  final String imagePath;
  final VoidCallback? onTap;
  final VoidCallback? onAddPressed;

  const CoffeeCard({
    super.key,
    required this.name,
    required this.price,
    required this.description,
    this.imagePath = 'assets/photo/coffee_cup.png',
    this.onTap,
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {
        // Дефолтная навигация, если onTap не передан
        context.go('/details', extra: name);
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Изображение (индивидуальное для каждой карточки)
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.coffee,
                    size: 40,
                    color: Colors.brown,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Информация
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$$price',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 201, 79, 43),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Кнопка добавления
            GestureDetector(
              onTap: onAddPressed ?? () {
                // Дефолтное действие для кнопки +
                context.go('/details', extra: name);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 201, 79, 43),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}