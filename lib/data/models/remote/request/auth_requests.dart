part of '../models.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckUniqueRequest {
  final String value;

  CheckUniqueRequest({required this.value});

  factory CheckUniqueRequest.fromJson(Map<String, dynamic> json) => _$CheckUniqueRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUniqueRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginRequest {
  final String phone;
  final String code;

  LoginRequest({required this.phone, required this.code});

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterRequest {
  final String login;
  final String phone;
  final String code;

  RegisterRequest({required this.login, required this.phone, required this.code});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
