part of '../models.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateProfileNamesRequest {
  final String? firstName;
  final String? secondName;
  final String? middleName;

  UpdateProfileNamesRequest({
    required this.firstName,
    required this.secondName,
    required this.middleName,
  });

  factory UpdateProfileNamesRequest.fromJson(Map<String, dynamic> json) => _$UpdateProfileNamesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileNamesRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateProfileStatusRequest {
  final String? status;

  UpdateProfileStatusRequest({required this.status});

  factory UpdateProfileStatusRequest.fromJson(Map<String, dynamic> json) => _$UpdateProfileStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileStatusRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateProfileBirthDateRequest {
  final String? birthDate;

  UpdateProfileBirthDateRequest({required this.birthDate});

  factory UpdateProfileBirthDateRequest.fromJson(Map<String, dynamic> json) => _$UpdateProfileBirthDateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileBirthDateRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateProfileGenderRequest {
  final String? gender;

  UpdateProfileGenderRequest({required this.gender});

  factory UpdateProfileGenderRequest.fromJson(Map<String, dynamic> json) => _$UpdateProfileGenderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileGenderRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateProfilePrivateRequest {
  final bool privateProfile;

  UpdateProfilePrivateRequest({required this.privateProfile});

  factory UpdateProfilePrivateRequest.fromJson(Map<String, dynamic> json) => _$UpdateProfilePrivateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfilePrivateRequestToJson(this);
}
