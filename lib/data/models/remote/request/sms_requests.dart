part of '../models.dart';

enum SmsCodeType { auth, register }

@JsonSerializable(fieldRename: FieldRename.snake)
class SendSmsCodeRequest {
  final String phone;
  final SmsCodeType type;

  SendSmsCodeRequest({required this.phone, required this.type});

  factory SendSmsCodeRequest.fromJson(Map<String, dynamic> json) => _$SendSmsCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendSmsCodeRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SmsCheckRequest {
  final String code;

  SmsCheckRequest({required this.code});

  factory SmsCheckRequest.fromJson(Map<String, dynamic> json) => _$SmsCheckRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SmsCheckRequestToJson(this);
}
