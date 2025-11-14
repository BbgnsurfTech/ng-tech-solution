import 'package:flutter/foundation.dart';
import '../models/notification_model.dart';

class NotificationsProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];
  int _unreadCount = 0;

  List<NotificationModel> get notifications => _notifications;
  List<NotificationModel> get unreadNotifications =>
      _notifications.where((n) => !n.isRead).toList();
  int get unreadCount => _unreadCount;

  void initializeMockData() {
    _notifications = [
      NotificationModel(
        id: '1',
        title: 'New Marketplace Message',
        message: 'John Doe sent you a message about your Maize listing.',
        type: NotificationType.marketplace,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        title: 'Loan Application Approved',
        message: 'Your loan application for ₦500,000 has been approved!',
        type: NotificationType.finance,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      NotificationModel(
        id: '3',
        title: 'Weather Alert',
        message: 'Heavy rainfall expected in your region. Take necessary precautions.',
        type: NotificationType.weather,
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: false,
        priority: NotificationPriority.high,
      ),
      NotificationModel(
        id: '4',
        title: 'Harvest Reminder',
        message: 'Your Cocoa crop is due for harvest in 7 days.',
        type: NotificationType.farm,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
      NotificationModel(
        id: '5',
        title: 'Price Update',
        message: 'Cassava prices have increased by 15% in Lagos market.',
        type: NotificationType.marketplace,
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
      NotificationModel(
        id: '6',
        title: 'Training Opportunity',
        message: 'Free training on modern farming techniques available. Register now!',
        type: NotificationType.advisory,
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        isRead: true,
      ),
      NotificationModel(
        id: '7',
        title: 'Payment Received',
        message: 'Payment of ₦45,000 received for your Rice listing.',
        type: NotificationType.finance,
        timestamp: DateTime.now().subtract(const Duration(days: 4)),
        isRead: true,
      ),
    ];

    _updateUnreadCount();
    notifyListeners();
  }

  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    _updateUnreadCount();
    notifyListeners();
  }

  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1 && !_notifications[index].isRead) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      _updateUnreadCount();
      notifyListeners();
    }
  }

  void markAllAsRead() {
    _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
    _updateUnreadCount();
    notifyListeners();
  }

  void deleteNotification(String notificationId) {
    _notifications.removeWhere((n) => n.id == notificationId);
    _updateUnreadCount();
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    _updateUnreadCount();
    notifyListeners();
  }

  void _updateUnreadCount() {
    _unreadCount = _notifications.where((n) => !n.isRead).length;
  }
}
