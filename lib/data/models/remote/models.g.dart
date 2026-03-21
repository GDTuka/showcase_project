// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: (json['id'] as num).toInt(),
  login: json['login'] as String,
  phone: json['phone'] as String,
  avatar: json['avatar'] as String?,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'login': instance.login,
  'phone': instance.phone,
  'avatar': instance.avatar,
  'created_at': instance.createdAt,
};

ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) => ProfileDto(
  userId: (json['user_id'] as num).toInt(),
  firstName: json['first_name'] as String?,
  secondName: json['second_name'] as String?,
  middleName: json['middle_name'] as String?,
  status: json['status'] as String?,
  privateProfile: json['private_profile'] as bool,
  birthDate: json['birth_date'] as String?,
  gender: json['gender'] as String?,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$ProfileDtoToJson(ProfileDto instance) => <String, dynamic>{
  'user_id': instance.userId,
  'first_name': instance.firstName,
  'second_name': instance.secondName,
  'middle_name': instance.middleName,
  'status': instance.status,
  'private_profile': instance.privateProfile,
  'birth_date': instance.birthDate,
  'gender': instance.gender,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

UserWithProfileDto _$UserWithProfileDtoFromJson(Map<String, dynamic> json) => UserWithProfileDto(
  id: (json['id'] as num).toInt(),
  login: json['login'] as String,
  phone: json['phone'] as String,
  avatar: json['avatar'] as String?,
  createdAt: json['created_at'] as String,
  profile: json['profile'] == null ? null : ProfileDto.fromJson(json['profile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserWithProfileDtoToJson(UserWithProfileDto instance) => <String, dynamic>{
  'id': instance.id,
  'login': instance.login,
  'phone': instance.phone,
  'avatar': instance.avatar,
  'created_at': instance.createdAt,
  'profile': instance.profile,
};

CheckUniqueRequest _$CheckUniqueRequestFromJson(Map<String, dynamic> json) =>
    CheckUniqueRequest(value: json['value'] as String);

Map<String, dynamic> _$CheckUniqueRequestToJson(CheckUniqueRequest instance) => <String, dynamic>{
  'value': instance.value,
};

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    LoginRequest(phone: json['phone'] as String, code: json['code'] as String);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) => <String, dynamic>{
  'phone': instance.phone,
  'code': instance.code,
};

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(login: json['login'] as String, phone: json['phone'] as String, code: json['code'] as String);

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) => <String, dynamic>{
  'login': instance.login,
  'phone': instance.phone,
  'code': instance.code,
};

UpdateProfileNamesRequest _$UpdateProfileNamesRequestFromJson(Map<String, dynamic> json) => UpdateProfileNamesRequest(
  firstName: json['first_name'] as String?,
  secondName: json['second_name'] as String?,
  middleName: json['middle_name'] as String?,
);

Map<String, dynamic> _$UpdateProfileNamesRequestToJson(UpdateProfileNamesRequest instance) => <String, dynamic>{
  'first_name': instance.firstName,
  'second_name': instance.secondName,
  'middle_name': instance.middleName,
};

UpdateProfileStatusRequest _$UpdateProfileStatusRequestFromJson(Map<String, dynamic> json) =>
    UpdateProfileStatusRequest(status: json['status'] as String?);

Map<String, dynamic> _$UpdateProfileStatusRequestToJson(UpdateProfileStatusRequest instance) => <String, dynamic>{
  'status': instance.status,
};

UpdateProfileBirthDateRequest _$UpdateProfileBirthDateRequestFromJson(Map<String, dynamic> json) =>
    UpdateProfileBirthDateRequest(birthDate: json['birth_date'] as String?);

Map<String, dynamic> _$UpdateProfileBirthDateRequestToJson(UpdateProfileBirthDateRequest instance) => <String, dynamic>{
  'birth_date': instance.birthDate,
};

UpdateProfileGenderRequest _$UpdateProfileGenderRequestFromJson(Map<String, dynamic> json) =>
    UpdateProfileGenderRequest(gender: json['gender'] as String?);

Map<String, dynamic> _$UpdateProfileGenderRequestToJson(UpdateProfileGenderRequest instance) => <String, dynamic>{
  'gender': instance.gender,
};

UpdateProfilePrivateRequest _$UpdateProfilePrivateRequestFromJson(Map<String, dynamic> json) =>
    UpdateProfilePrivateRequest(privateProfile: json['private_profile'] as bool);

Map<String, dynamic> _$UpdateProfilePrivateRequestToJson(UpdateProfilePrivateRequest instance) => <String, dynamic>{
  'private_profile': instance.privateProfile,
};

CreateRelationRequest _$CreateRelationRequestFromJson(Map<String, dynamic> json) =>
    CreateRelationRequest(relatedUserId: (json['related_user_id'] as num).toInt());

Map<String, dynamic> _$CreateRelationRequestToJson(CreateRelationRequest instance) => <String, dynamic>{
  'related_user_id': instance.relatedUserId,
};

ReplyRelationRequest _$ReplyRelationRequestFromJson(Map<String, dynamic> json) =>
    ReplyRelationRequest(userId: (json['user_id'] as num).toInt(), relationType: json['relation_type'] as String);

Map<String, dynamic> _$ReplyRelationRequestToJson(ReplyRelationRequest instance) => <String, dynamic>{
  'user_id': instance.userId,
  'relation_type': instance.relationType,
};

DeleteRelationRequest _$DeleteRelationRequestFromJson(Map<String, dynamic> json) =>
    DeleteRelationRequest(userId: (json['user_id'] as num).toInt());

Map<String, dynamic> _$DeleteRelationRequestToJson(DeleteRelationRequest instance) => <String, dynamic>{
  'user_id': instance.userId,
};

const _$SmsCodeTypeEnumMap = {SmsCodeType.auth: 'auth', SmsCodeType.register: 'register'};

SendSmsCodeRequest _$SendSmsCodeRequestFromJson(Map<String, dynamic> json) =>
    SendSmsCodeRequest(phone: json['phone'] as String, type: $enumDecode(_$SmsCodeTypeEnumMap, json['type']));

Map<String, dynamic> _$SendSmsCodeRequestToJson(SendSmsCodeRequest instance) => <String, dynamic>{
  'phone': instance.phone,
  'type': _$SmsCodeTypeEnumMap[instance.type]!,
};

SmsCheckRequest _$SmsCheckRequestFromJson(Map<String, dynamic> json) => SmsCheckRequest(code: json['code'] as String);

Map<String, dynamic> _$SmsCheckRequestToJson(SmsCheckRequest instance) => <String, dynamic>{'code': instance.code};

UserSearchRequest _$UserSearchRequestFromJson(Map<String, dynamic> json) => UserSearchRequest(
  login: json['login'] as String?,
  relationType: json['relation_type'] as String?,
  limit: (json['limit'] as num?)?.toInt(),
  offset: (json['offset'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserSearchRequestToJson(UserSearchRequest instance) => <String, dynamic>{
  'login': instance.login,
  'relation_type': instance.relationType,
  'limit': instance.limit,
  'offset': instance.offset,
};

UserSearchResponse _$UserSearchResponseFromJson(Map<String, dynamic> json) => UserSearchResponse(
  users: (json['users'] as List<dynamic>).map((e) => UserDto.fromJson(e as Map<String, dynamic>)).toList(),
  limit: (json['limit'] as num).toInt(),
  offset: (json['offset'] as num).toInt(),
);

Map<String, dynamic> _$UserSearchResponseToJson(UserSearchResponse instance) => <String, dynamic>{
  'users': instance.users,
  'limit': instance.limit,
  'offset': instance.offset,
};
