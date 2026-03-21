part of '../../models.dart';

/// Модель данных пользователя с профилем
@JsonSerializable(fieldRename: FieldRename.snake)
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
  final String createdAt;

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
  factory UserWithProfileDto.fromJson(Map<String, dynamic> json) => _$UserWithProfileDtoFromJson(json);

  /// Преобразует модель в JSON формат
  Map<String, dynamic> toJson() => _$UserWithProfileDtoToJson(this);
}
