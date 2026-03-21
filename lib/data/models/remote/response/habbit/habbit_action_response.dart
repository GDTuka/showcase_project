part of '../../models.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HabbitActionResponse {
  final String message;

  HabbitActionResponse({required this.message});

  factory HabbitActionResponse.fromJson(Map<String, dynamic> json) => _$HabbitActionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HabbitActionResponseToJson(this);
}
