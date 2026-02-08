import 'package:elevate_flower_app/features/notifications_list/domain/entities/notification_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_item_model.g.dart';

@JsonSerializable()
class NotificationItemModel {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "body")
  final String? body;

  @JsonKey(name: "isRead")
  final bool? isRead;

  NotificationItemModel({this.id, this.title, this.body, this.isRead});

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemModelToJson(this);

  /// Convert to Entity
  NotificationItemEntity toEntity() => NotificationItemEntity(
    id: id ?? 0,
    title: title ?? '',
    body: body ?? '',
    isRead: isRead ?? false,
  );
}
