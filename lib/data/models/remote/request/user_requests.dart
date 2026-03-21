part of '../models.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserSearchRequest {
  final String? login;
  final String? relationType;
  final int? limit;
  final int? offset;

  UserSearchRequest({
    this.login,
    this.relationType,
    this.limit,
    this.offset,
  });

  factory UserSearchRequest.fromJson(Map<String, dynamic> json) => _$UserSearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserSearchRequestToJson(this);

  Map<String, dynamic> toQueryParams() {
    return {
      if (login != null) 'login': login,
      if (relationType != null) 'relation_type': relationType,
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
    };
  }
}
