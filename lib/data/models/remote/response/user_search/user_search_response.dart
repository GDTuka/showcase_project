import 'package:showcase_project/data/models/remote/dto/user/user_dto.dart';

/// Модель данных для ответа поиска пользователей
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
  factory UserSearchResponse.fromJson(Map<String, dynamic> json) {
    final usersList = (json['users'] as List<dynamic>)
        .map((user) => UserDto.fromJson(user as Map<String, dynamic>))
        .toList();

    return UserSearchResponse(users: usersList, limit: json['limit'] as int, offset: json['offset'] as int);
  }

  /// Преобразует модель в JSON формат
  Map<String, dynamic> toJson() {
    return {'users': users.map((user) => user.toJson()).toList(), 'limit': limit, 'offset': offset};
  }
}
