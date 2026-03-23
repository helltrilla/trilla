import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeliveryScreen extends StatefulWidget {
  final String coffeeName;
  final String coffeePrice;
  final int quantity;
  final String size;

  const DeliveryScreen({
    super.key,
    required this.coffeeName,
    required this.coffeePrice,
    required this.quantity,
    required this.size,
  });

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  List<Courier> _couriers = [];
  Courier? _selectedCourier;
  bool _isLoadingCouriers = true;
  
  final List<String> _streets = [
    '96th St', '95th St', '96th St', '85th Street', '86th Street',
    '91st Avenue', '90th Avenue', '91st Avenue', '3rd Ave', '2nd Ave',
    'Nirmala Girls HSS', '81st Ave', '19th Avenue', '86th St'
  ];
  
  @override
  void initState() {
    super.initState();
    _fetchCouriers();
  }
  
  Future<void> _fetchCouriers() async {
    try {
      final response = await http.get(
        Uri.parse('https://randomuser.me/api/?results=3&nat=us'),
      ).timeout(const Duration(seconds: 5));
      
      setState(() {
        _couriers = [
          Courier(id: 1, name: 'Brooklyn Simmons', rating: 4.8, phone: '+1 234 567 890', status: 'Available'),
          Courier(id: 2, name: 'John Doe', rating: 4.7, phone: '+1 987 654 321', status: 'Busy'),
          Courier(id: 3, name: 'Emily Johnson', rating: 4.9, phone: '+1 555 123 456', status: 'Available'),
        ];
        _selectedCourier = _couriers.first;
        _isLoadingCouriers = false;
      });
    } catch (e) {
      setState(() {
        _couriers = [
          Courier(id: 1, name: 'Brooklyn Simmons', rating: 4.8, phone: '+1 234 567 890', status: 'Available'),
          Courier(id: 2, name: 'John Doe', rating: 4.7, phone: '+1 987 654 321', status: 'Busy'),
          Courier(id: 3, name: 'Emily Johnson', rating: 4.9, phone: '+1 555 123 456', status: 'Available'),
        ];
        _selectedCourier = _couriers.first;
        _isLoadingCouriers = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final totalPrice = double.parse(widget.coffeePrice) * widget.quantity;
    final deliveryFee = 2.0;
    final finalTotal = totalPrice + deliveryFee;
    
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222222),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Delivery Tracking',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Карта-заглушка (имитация карты)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.brown[800]!, Colors.brown[900]!],
                ),
              ),
              child: Stack(
                children: [
                  // Имитация улиц
                  CustomPaint(
                    painter: MapPainter(),
                    size: Size.infinite,
                  ),
                  // Маркеры
                  Positioned(
                    left: 50,
                    top: 80,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC94F2B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_cafe, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text('Coffee Shop', style: TextStyle(color: Colors.white, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 60,
                    bottom: 60,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text('You', style: TextStyle(color: Colors.white, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                  // Линия маршрута
                  Center(
                    child: CustomPaint(
                      painter: RoutePainter(),
                      size: const Size(300, 150),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Информация о доставке
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC94F2B).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.delivery_dining,
                          color: Color(0xFFC94F2B),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Delivered your order',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'We will deliver your goods to you in the shortest possible time.',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        '10 minutes left',
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'On Time',
                          style: TextStyle(color: Colors.green, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Адрес доставки
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Color(0xFFC94F2B), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Delivery to JI. Kpg Sutoyo',
                    style: TextStyle(color: Colors.grey[300], fontSize: 14),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Список улиц (как на картинке)
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _streets.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _streets[index],
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Информация о заказе
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.brown[700],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.coffee, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.coffeeName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.size} · ${widget.quantity} x',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Стоимость доставки
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Fee',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                      Text(
                        '\$${deliveryFee.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${finalTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFFC94F2B),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Выбор курьера
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Personal Courier',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'View all',
                    style: TextStyle(
                      color: const Color(0xFFC94F2B),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            if (_isLoadingCouriers)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFC94F2B),
                  ),
                ),
              )
            else
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _couriers.length,
                  itemBuilder: (context, index) {
                    final courier = _couriers[index];
                    final isSelected = _selectedCourier?.id == courier.id;
                    return GestureDetector(
                      onTap: () {
                        if (courier.status == 'Available') {
                          setState(() {
                            _selectedCourier = courier;
                          });
                        }
                      },
                      child: Container(
                        width: 140,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFC94F2B).withValues(alpha: 0.2)
                              : Colors.grey[800],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFC94F2B)
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.brown[700],
                              child: Icon(
                                Icons.person,
                                color: Colors.brown[300],
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    courier.name,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.grey[300],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, size: 10, color: Colors.amber),
                                      Text(
                                        ' ${courier.rating}',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            
            const SizedBox(height: 24),
            
            // Кнопка подтверждения
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Order placed! Courier ${_selectedCourier?.name} will deliver your order',
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC94F2B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Confirm Order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Рисовальщик карты
class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    
    // Рисуем линии улиц
    for (int i = 0; i < 10; i++) {
      canvas.drawLine(
        Offset(0, size.height * (i / 10)),
        Offset(size.width, size.height * (i / 10)),
        paint,
      );
    }
    
    for (int i = 0; i < 10; i++) {
      canvas.drawLine(
        Offset(size.width * (i / 10), 0),
        Offset(size.width * (i / 10), size.height),
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Рисовальщик маршрута
class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC94F2B)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    
    final path = Path();
    path.moveTo(0, size.height);
    path.cubicTo(
      size.width * 0.3, size.height * 0.7,
      size.width * 0.6, size.height * 0.3,
      size.width, 0,
    );
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Модель курьера
class Courier {
  final int id;
  final String name;
  final double rating;
  final String phone;
  final String status;

  Courier({
    required this.id,
    required this.name,
    required this.rating,
    required this.phone,
    required this.status,
  });
}