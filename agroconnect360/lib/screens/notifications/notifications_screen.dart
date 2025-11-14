import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../models/notification_model.dart';
import '../../providers/notifications_provider.dart';
import '../../widgets/empty_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          Consumer<NotificationsProvider>(
            builder: (context, provider, _) {
              if (provider.notifications.isEmpty) return const SizedBox();

              return PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'mark_all_read') {
                    provider.markAllAsRead();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('All notifications marked as read'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else if (value == 'clear_all') {
                    _showClearAllDialog(context, provider);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'mark_all_read',
                    child: Row(
                      children: [
                        Icon(Icons.done_all, size: 20),
                        SizedBox(width: 12),
                        Text('Mark all as read'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'clear_all',
                    child: Row(
                      children: [
                        Icon(Icons.delete_sweep, size: 20),
                        SizedBox(width: 12),
                        Text('Clear all'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<NotificationsProvider>(
        builder: (context, provider, _) {
          if (provider.notifications.isEmpty) {
            return const EmptyState(
              icon: Icons.notifications_none,
              title: 'No Notifications',
              message: 'You\'re all caught up! New notifications will appear here.',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: provider.notifications.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final notification = provider.notifications[index];
              return _NotificationTile(
                notification: notification,
                onTap: () {
                  provider.markAsRead(notification.id);
                  _handleNotificationTap(context, notification);
                },
                onDismiss: () {
                  provider.deleteNotification(notification.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Notification deleted'),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          provider.addNotification(notification);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showClearAllDialog(BuildContext context, NotificationsProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text('Are you sure you want to delete all notifications? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              provider.clearAll();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All notifications cleared')),
              );
            },
            child: const Text('CLEAR ALL', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _handleNotificationTap(BuildContext context, NotificationModel notification) {
    // Handle navigation based on notification type
    // This is a placeholder - implement actual navigation logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opened: ${notification.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getNotificationConfig(notification.type);
    final isPriorityHigh = notification.priority == NotificationPriority.high;

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: AppColors.error,
        child: const Icon(Icons.delete, color: AppColors.textWhite),
      ),
      child: Material(
        color: notification.isRead
            ? Colors.transparent
            : AppColors.primary.withOpacity(0.05),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: config.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    config.icon,
                    color: config.color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontWeight: notification.isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          if (isPriorityHigh)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'URGENT',
                                style: TextStyle(
                                  color: AppColors.textWhite,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.message,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            notification.timeAgo,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: AppColors.textSecondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            config.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: config.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!notification.isRead)
                  Container(
                    margin: const EdgeInsets.only(left: 8, top: 4),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _NotificationConfig _getNotificationConfig(NotificationType type) {
    switch (type) {
      case NotificationType.marketplace:
        return _NotificationConfig(
          icon: Icons.shopping_bag,
          color: AppColors.secondary,
          label: 'Marketplace',
        );
      case NotificationType.farm:
        return _NotificationConfig(
          icon: Icons.agriculture,
          color: AppColors.primary,
          label: 'Farm',
        );
      case NotificationType.finance:
        return _NotificationConfig(
          icon: Icons.account_balance_wallet,
          color: AppColors.accent,
          label: 'Finance',
        );
      case NotificationType.weather:
        return _NotificationConfig(
          icon: Icons.cloud,
          color: AppColors.info,
          label: 'Weather',
        );
      case NotificationType.advisory:
        return _NotificationConfig(
          icon: Icons.lightbulb,
          color: AppColors.warning,
          label: 'Advisory',
        );
      case NotificationType.system:
        return _NotificationConfig(
          icon: Icons.info,
          color: AppColors.textSecondary,
          label: 'System',
        );
    }
  }
}

class _NotificationConfig {
  final IconData icon;
  final Color color;
  final String label;

  _NotificationConfig({
    required this.icon,
    required this.color,
    required this.label,
  });
}
