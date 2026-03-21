part of '../../models.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UploadAvatarResponse {
  final String message;
  final String avatar;

  UploadAvatarResponse({required this.message, required this.avatar});

  factory UploadAvatarResponse.fromJson(Map<String, dynamic> json) => _$UploadAvatarResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadAvatarResponseToJson(this);
}
