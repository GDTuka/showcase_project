part of '../../models.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HabbitDto {
  final int id;
  final int authorId;
  final String title;
  final String description;
  final int complitionInPeriodCount;
  final String complitionPeriod;
  final bool archived;
  final String createdAt;

  HabbitDto({
    required this.id,
    required this.authorId,
    required this.title,
    required this.description,
    required this.complitionInPeriodCount,
    required this.complitionPeriod,
    required this.archived,
    required this.createdAt,
  });

  factory HabbitDto.fromJson(Map<String, dynamic> json) => _$HabbitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HabbitDtoToJson(this);
}
