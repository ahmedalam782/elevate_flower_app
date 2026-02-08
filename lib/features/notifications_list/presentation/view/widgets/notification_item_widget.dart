import 'package:elevate_flower_app/features/notifications_list/domain/entities/notification_item_entity.dart';
import 'package:flutter/material.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationItemEntity notification;

  const NotificationItemWidget({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification.isRead ? Colors.white : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notification Bell Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.grey[700],
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // Notification Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with emoji/icon
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: notification.isRead
                              ? FontWeight.w500
                              : FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Unread indicator
                    if (!notification.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),

                // Body/Description
                Text(
                  notification.body,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}