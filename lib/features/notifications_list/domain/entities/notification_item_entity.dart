class NotificationItemEntity {
  final int id;
  final String title;
  final String body;
  final bool isRead;

  NotificationItemEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
  });

  NotificationItemEntity copyWith({
    int? id,
    String? title,
    String? body,
    bool? isRead,
  }) {
    return NotificationItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
    );
  }
}