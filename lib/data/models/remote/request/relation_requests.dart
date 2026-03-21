part of '../models.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateRelationRequest {
  final int relatedUserId;

  CreateRelationRequest({required this.relatedUserId});

  factory CreateRelationRequest.fromJson(Map<String, dynamic> json) => _$CreateRelationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRelationRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReplyRelationRequest {
  final int userId;
  final String relationType;

  ReplyRelationRequest({required this.userId, required this.relationType});

  factory ReplyRelationRequest.fromJson(Map<String, dynamic> json) => _$ReplyRelationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyRelationRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DeleteRelationRequest {
  final int userId;

  DeleteRelationRequest({required this.userId});

  factory DeleteRelationRequest.fromJson(Map<String, dynamic> json) => _$DeleteRelationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteRelationRequestToJson(this);
}
