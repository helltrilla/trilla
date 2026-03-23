import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;
  bool _isRefreshing = false;
  // API URL
  final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  @override
  void initState() {
    super.initState();

    // никакой логии в ui быть не должно
    // заебись использовать bloc
    // ui -> bloc -> usecase -> repository -> datasource (поток данных в приложении )

    //async методов в initstate не долно быть
    _fetchNotifications(); //+ вызывается при при каждом заходе на экран
  }

  // Получение уведомлений с API
  Future<void> _fetchNotifications() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Получаем посты (используем как уведомления)
      final response = await http
          .get(
            Uri.parse('$_baseUrl/posts?_limit=15'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _notifications = data.map((item) {
            return NotificationModel(
              id: item['id'],
              title: 'New Coffee Update',
              message: item['title'],
              body: item['body'],
              timestamp: DateTime.now().subtract(
                Duration(minutes: item['id'] * 10),
              ),
              isRead: false,
            );
          }).toList();
          _isLoading = false;
        });
      } else {
        _useLocalFallback();
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      _useLocalFallback();
    }
  }

  // Локальный фолбэк на случай ошибки API
  void _useLocalFallback() {
    setState(() {
      _notifications = [
        NotificationModel(
          id: 1,
          title: 'Welcome!',
          message: 'Welcome to Coffee App',
          body: 'Start exploring our delicious coffee menu',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isRead: false,
        ),
        NotificationModel(
          id: 2,
          title: 'Special Offer',
          message: 'Buy one get one free',
          body: 'Limited time offer on all coffee',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          isRead: false,
        ),
        NotificationModel(
          id: 3,
          title: 'New Arrival',
          message: 'Try our new seasonal blend',
          body: 'Limited edition coffee now available',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          isRead: false,
        ),
      ];
      _isLoading = false;
    });
  }

  // Обновление (pull to refresh)
  Future<void> _refreshNotifications() async {
    setState(() {
      _isRefreshing = true;
    });
    await _fetchNotifications();
    setState(() {
      _isRefreshing = false;
    });
  }

  // Добавление случайного уведомления (POST запрос)
  Future<void> _addRandomNotification() async {
    try {
      final randomMessages = [
        'Your coffee is ready for pickup!',
        'New promotion: 30% off on cold brew',
        'Don\'t forget to rate your last order',
        'Free delivery on orders over \$10',
        'Your favorite coffee is back in stock',
        'Happy hour: 20% off all coffee',
        'New coffee blend just arrived',
        'Your loyalty points are expiring soon',
      ];

      final randomIndex =
          DateTime.now().millisecondsSinceEpoch % randomMessages.length;
      final message = randomMessages[randomIndex.toInt()];

      // Отправляем POST запрос для создания нового уведомления
      final response = await http.post(
        Uri.parse('$_baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': 'New Notification',
          'body': message,
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        final newData = json.decode(response.body);
        setState(() {
          _notifications.insert(
            0,
            NotificationModel(
              id: newData['id'],
              title: 'New Notification',
              message: message,
              body: message,
              timestamp: DateTime.now(),
              isRead: false,
            ),
          );
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('New notification added'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        // Если POST не работает, добавляем локально
        _addLocalNotification(message);
      }
    } catch (e) {
      print('Error adding notification: $e');
      _addLocalNotification('New notification arrived');
    }
  }

  // Локальное добавление уведомления
  void _addLocalNotification(String message) {
    setState(() {
      _notifications.insert(
        0,
        NotificationModel(
          id: DateTime.now().millisecondsSinceEpoch,
          title: 'New Notification',
          message: message,
          body: message,
          timestamp: DateTime.now(),
          isRead: false,
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  // Отметить как прочитанное
  void _markAsRead(int id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _notifications[index].isRead = true;
      }
    });
  }

  // Удалить уведомление
  void _deleteNotification(int id) {
    setState(() {
      _notifications.removeWhere((n) => n.id == id);
    });
  }

  // Очистить все уведомления
  void _clearAllNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear all notifications'),
        content: const Text(
          'Are you sure you want to clear all notifications?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _notifications.clear();
              });
              Navigator.pop(context);
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 34, 34, 34),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _addRandomNotification,
            icon: const Icon(Icons.add_alert, color: Colors.white),
            tooltip: 'Add random notification',
          ),
          IconButton(
            onPressed: _clearAllNotifications,
            icon: const Icon(Icons.delete_sweep, color: Colors.white),
            tooltip: 'Clear all',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 201, 79, 43),
              ),
            )
          : _notifications.isEmpty
          ? _buildEmptyState()
          : RefreshIndicator(
              onRefresh: _refreshNotifications,
              color: const Color.fromARGB(255, 201, 79, 43),
              child: ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return _buildNotificationCard(notification, index);
                },
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 80, color: Colors.grey[600]),
          const SizedBox(height: 16),
          Text(
            'No notifications yet',
            style: TextStyle(color: Colors.grey[400], fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Pull down to refresh or tap + to add',
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _addRandomNotification,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 201, 79, 43),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Add Test Notification'),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification, int index) {
    return Dismissible(
      key: Key(notification.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _deleteNotification(notification.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () => _markAsRead(notification.id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification.isRead
                ? Colors.grey[800]
                : const Color.fromARGB(255, 45, 45, 45),
            borderRadius: BorderRadius.circular(12),
            border: notification.isRead
                ? null
                : Border.all(
                    color: const Color.fromARGB(255, 201, 79, 43),
                    width: 1,
                  ),
          ),
          child: Row(
            children: [
              // Иконка
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: notification.isRead
                      ? Colors.grey[700]
                      : const Color.fromARGB(
                          255,
                          201,
                          79,
                          43,
                        ).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  notification.isRead
                      ? Icons.notifications_none
                      : Icons.notifications_active,
                  color: notification.isRead
                      ? Colors.grey[400]
                      : const Color.fromARGB(255, 201, 79, 43),
                ),
              ),
              const SizedBox(width: 12),
              // Контент
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 201, 79, 43),
                              shape: BoxShape.circle,
                            ),
                          ),
                        if (!notification.isRead) const SizedBox(width: 8),
                        Text(
                          notification.title,
                          style: TextStyle(
                            color: notification.isRead
                                ? Colors.grey[400]
                                : Colors.white,
                            fontWeight: notification.isRead
                                ? FontWeight.normal
                                : FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _formatTime(notification.timestamp),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notification.message,
                      style: TextStyle(
                        color: notification.isRead
                            ? Colors.grey[500]
                            : Colors.grey[300],
                        fontSize: 14,
                      ),
                    ),
                    if (notification.body.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        notification.body,
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

// это должео быть в /domain/entites/notification.dart
// Модель уведомления
class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String body;
  final DateTime timestamp;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.body,
    required this.timestamp,
    required this.isRead,
  });

  // и еще пизадто иметь у класса всякие tojson fromjson
}
