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
  profile: json['profile'] == null ? null : ProfileDto.fromJson(json['profile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'login': instance.login,
  'phone': instance.phone,
  'avatar': instance.avatar,
  'created_at': instance.createdAt,
  'profile': instance.profile,
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

HabbitDto _$HabbitDtoFromJson(Map<String, dynamic> json) => HabbitDto(
  id: (json['id'] as num).toInt(),
  authorId: (json['author_id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  complitionInPeriodCount: (json['complition_in_period_count'] as num).toInt(),
  complitionPeriod: json['complition_period'] as String,
  archived: json['archived'] as bool,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$HabbitDtoToJson(HabbitDto instance) => <String, dynamic>{
  'id': instance.id,
  'author_id': instance.authorId,
  'title': instance.title,
  'description': instance.description,
  'complition_in_period_count': instance.complitionInPeriodCount,
  'complition_period': instance.complitionPeriod,
  'archived': instance.archived,
  'created_at': instance.createdAt,
};

HabbitRequestDto _$HabbitRequestDtoFromJson(Map<String, dynamic> json) => HabbitRequestDto(
  id: (json['id'] as num).toInt(),
  habbitId: (json['habbit_id'] as num).toInt(),
  requesterId: (json['requester_id'] as num).toInt(),
  targetUserId: (json['target_user_id'] as num).toInt(),
  accepted: json['accepted'] as bool,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$HabbitRequestDtoToJson(HabbitRequestDto instance) => <String, dynamic>{
  'id': instance.id,
  'habbit_id': instance.habbitId,
  'requester_id': instance.requesterId,
  'target_user_id': instance.targetUserId,
  'accepted': instance.accepted,
  'created_at': instance.createdAt,
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

CreateHabbitRequest _$CreateHabbitRequestFromJson(Map<String, dynamic> json) => CreateHabbitRequest(
  title: json['title'] as String,
  description: json['description'] as String,
  complitionInPeriodCount: (json['complition_in_period_count'] as num).toInt(),
  complitionPeriod: json['complition_period'] as String,
);

Map<String, dynamic> _$CreateHabbitRequestToJson(CreateHabbitRequest instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'complition_in_period_count': instance.complitionInPeriodCount,
  'complition_period': instance.complitionPeriod,
};

MarkHabbitCompletionRequest _$MarkHabbitCompletionRequestFromJson(Map<String, dynamic> json) =>
    MarkHabbitCompletionRequest(
      complition: json['complition'] as String,
      complitedAt: json['complited_at'] as String,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$MarkHabbitCompletionRequestToJson(MarkHabbitCompletionRequest instance) => <String, dynamic>{
  'complition': instance.complition,
  'complited_at': instance.complitedAt,
  'note': instance.note,
};

ToggleHabbitArchiveRequest _$ToggleHabbitArchiveRequestFromJson(Map<String, dynamic> json) =>
    ToggleHabbitArchiveRequest(archived: json['archived'] as bool);

Map<String, dynamic> _$ToggleHabbitArchiveRequestToJson(ToggleHabbitArchiveRequest instance) => <String, dynamic>{
  'archived': instance.archived,
};

SendSharedHabbitRequest _$SendSharedHabbitRequestFromJson(Map<String, dynamic> json) =>
    SendSharedHabbitRequest(targetUserId: (json['target_user_id'] as num).toInt());

Map<String, dynamic> _$SendSharedHabbitRequestToJson(SendSharedHabbitRequest instance) => <String, dynamic>{
  'target_user_id': instance.targetUserId,
};

GetSharedHabbitRequestsRequest _$GetSharedHabbitRequestsRequestFromJson(Map<String, dynamic> json) =>
    GetSharedHabbitRequestsRequest(
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      accepted: json['accepted'] as bool?,
    );

Map<String, dynamic> _$GetSharedHabbitRequestsRequestToJson(GetSharedHabbitRequestsRequest instance) =>
    <String, dynamic>{'limit': instance.limit, 'offset': instance.offset, 'accepted': instance.accepted};

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

HabbitActionResponse _$HabbitActionResponseFromJson(Map<String, dynamic> json) =>
    HabbitActionResponse(message: json['message'] as String);

Map<String, dynamic> _$HabbitActionResponseToJson(HabbitActionResponse instance) => <String, dynamic>{
  'message': instance.message,
};

SharedHabbitRequestsResponse _$SharedHabbitRequestsResponseFromJson(Map<String, dynamic> json) =>
    SharedHabbitRequestsResponse(
      requests: (json['requests'] as List<dynamic>)
          .map((e) => HabbitRequestDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      limit: (json['limit'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
    );

Map<String, dynamic> _$SharedHabbitRequestsResponseToJson(SharedHabbitRequestsResponse instance) => <String, dynamic>{
  'requests': instance.requests,
  'limit': instance.limit,
  'offset': instance.offset,
};

UploadAvatarResponse _$UploadAvatarResponseFromJson(Map<String, dynamic> json) =>
    UploadAvatarResponse(message: json['message'] as String, avatar: json['avatar'] as String);

Map<String, dynamic> _$UploadAvatarResponseToJson(UploadAvatarResponse instance) => <String, dynamic>{
  'message': instance.message,
  'avatar': instance.avatar,
};
