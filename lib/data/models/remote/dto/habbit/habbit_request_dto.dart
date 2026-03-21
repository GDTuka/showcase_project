part of '../../models.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HabbitRequestDto {
  final int id;
  final int habbitId;
  final int requesterId;
  final int targetUserId;
  final bool accepted;
  final String createdAt;

  HabbitRequestDto({
    required this.id,
    required this.habbitId,
    required this.requesterId,
    required this.targetUserId,
    required this.accepted,
    required this.createdAt,
  });

  factory HabbitRequestDto.fromJson(Map<String, dynamic> json) => _$HabbitRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HabbitRequestDtoToJson(this);
}
