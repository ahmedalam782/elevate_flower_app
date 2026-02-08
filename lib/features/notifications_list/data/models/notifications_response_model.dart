import 'package:elevate_flower_app/features/notifications_list/data/models/notification_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notifications_response_model.g.dart';

@JsonSerializable()
class NotificationsResponseModel {
  final String message;
  final Metadata metadata;
  final List<NotificationItemModel> notifications;

  NotificationsResponseModel({
    required this.message,
    required this.metadata,
    required this.notifications,
  });

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseModelToJson(this);
}

@JsonSerializable()
class Metadata {
  final int currentPage;
  final int totalPages;
  final int limit;
  final int totalItems;
  final int unreadCount;

  Metadata({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
    required this.unreadCount,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

