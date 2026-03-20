import 'package:showcase_project/data/models/remote/dto/profile/profile_dto.dart';

/// Модель данных пользователя с профилем
class UserWithProfileDto {
  /// ID пользователя
  final int id;

  /// Логин
  final String login;

  /// Телефон
  final String phone;

  /// Аватар (может быть null)
  final String? avatar;

  /// Дата создания
  final DateTime createdAt;

  /// Профиль пользователя (может быть null)
  final ProfileDto? profile;

  /// Создает экземпляр модели пользователя с профилем
  UserWithProfileDto({
    required this.id,
    required this.login,
    required this.phone,
    this.avatar,
    required this.createdAt,
    this.profile,
  });

  /// Фабричный метод для создания [UserWithProfileDto] из JSON
  factory UserWithProfileDto.fromJson(Map<String, dynamic> json) {
    return UserWithProfileDto(
      id: json['id'] as int,
      login: json['login'] as String,
      phone: json['phone'] as String,
      avatar: json['avatar'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      profile: json['profile'] != null ? ProfileDto.fromJson(json['profile'] as Map<String, dynamic>) : null,
    );
  }

  /// Преобразует модель в JSON формат
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'phone': phone,
      'avatar': avatar,
      'created_at': createdAt.toIso8601String(),
      'profile': profile?.toJson(),
    };
  }
}
