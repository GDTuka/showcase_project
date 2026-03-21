part of '../models.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateHabbitRequest {
  final String title;
  final String description;
  final int complitionInPeriodCount;
  final String complitionPeriod;

  CreateHabbitRequest({
    required this.title,
    required this.description,
    required this.complitionInPeriodCount,
    required this.complitionPeriod,
  });

  factory CreateHabbitRequest.fromJson(Map<String, dynamic> json) => _$CreateHabbitRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateHabbitRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MarkHabbitCompletionRequest {
  final String complition;
  final String complitedAt;
  final String? note;

  MarkHabbitCompletionRequest({required this.complition, required this.complitedAt, required this.note});

  factory MarkHabbitCompletionRequest.fromJson(Map<String, dynamic> json) => _$MarkHabbitCompletionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MarkHabbitCompletionRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ToggleHabbitArchiveRequest {
  final bool archived;

  ToggleHabbitArchiveRequest({required this.archived});

  factory ToggleHabbitArchiveRequest.fromJson(Map<String, dynamic> json) => _$ToggleHabbitArchiveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ToggleHabbitArchiveRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SendSharedHabbitRequest {
  final int targetUserId;

  SendSharedHabbitRequest({required this.targetUserId});

  factory SendSharedHabbitRequest.fromJson(Map<String, dynamic> json) => _$SendSharedHabbitRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendSharedHabbitRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GetSharedHabbitRequestsRequest {
  final int? limit;
  final int? offset;
  final bool? accepted;

  GetSharedHabbitRequestsRequest({required this.limit, required this.offset, required this.accepted});

  factory GetSharedHabbitRequestsRequest.fromJson(Map<String, dynamic> json) => _$GetSharedHabbitRequestsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetSharedHabbitRequestsRequestToJson(this);

  Map<String, dynamic> toQueryParams() => {
    if (limit != null) 'limit': limit,
    if (offset != null) 'offset': offset,
    if (accepted != null) 'accepted': accepted,
  };
}
