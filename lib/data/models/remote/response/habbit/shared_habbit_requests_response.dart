part of '../../models.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SharedHabbitRequestsResponse {
  final List<HabbitRequestDto> requests;
  final int limit;
  final int offset;

  SharedHabbitRequestsResponse({required this.requests, required this.limit, required this.offset});

  factory SharedHabbitRequestsResponse.fromJson(Map<String, dynamic> json) => _$SharedHabbitRequestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SharedHabbitRequestsResponseToJson(this);
}
