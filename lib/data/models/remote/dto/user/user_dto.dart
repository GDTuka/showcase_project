part of '../../models.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserDto {
  /// Уникальный идентификатор пользователя
  final int id;

  /// Логин пользователя в системе
  final String login;

  /// Номер телефона пользователя
  final String phone;

  /// Аватар пользователя
  final String? avatar;

  /// Дата и время создания аккаунта в формате ISO 8601
  final String createdAt;

  /// Создает экземпляр модели пользователя
  /// [int id] - идентификатор
  /// [String login] - логин
  /// [String phone] - телефон
  /// [String createdAt] - дата создания
  UserDto({required this.id, required this.login, required this.phone, this.avatar, required this.createdAt});

  /// Фабричный метод для создания [UserDto] из JSON
  /// [Map<String, dynamic> json] - данные от сервера
  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  /// Преобразует модель в JSON формат
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
