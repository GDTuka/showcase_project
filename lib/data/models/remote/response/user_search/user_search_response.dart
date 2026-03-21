part of '../../models.dart';

/// Модель данных для ответа поиска пользователей
@JsonSerializable(fieldRename: FieldRename.snake)
class UserSearchResponse {
  /// Список пользователей
  final List<UserDto> users;

  /// Количество результатов
  final int limit;

  /// Смещение
  final int offset;

  /// Создает экземпляр модели ответа поиска
  UserSearchResponse({required this.users, required this.limit, required this.offset});

  /// Фабричный метод для создания [UserSearchResponse] из JSON
  factory UserSearchResponse.fromJson(Map<String, dynamic> json) => _$UserSearchResponseFromJson(json);

  /// Преобразует модель в JSON формат
  Map<String, dynamic> toJson() => _$UserSearchResponseToJson(this);
}
