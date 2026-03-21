import 'package:flutter/material.dart';
import 'package:showcase_project/data/api/api/user_api.dart';
import 'package:showcase_project/data/models/remote/models.dart';

/// Интерфейс репозитория для работы с пользователями
abstract interface class IUserRepository {
  /// Получает профиль текущего пользователя с данными профиля
  Future<void> getCurrentUser();

  /// Получает профиль другого пользователя по ID
  Future<UserDto> getUserById(int userId);

  /// Ищет пользователей с пагинацией и фильтрацией
  Future<UserSearchResponse> searchUsers({String? login, String? relationType, int? limit, int? offset});

  ValueNotifier<UserDto?> get userNotifier;
}

/// Репозиторий для работы с пользователями
/// Скрывает детали реализации API от UI слоя
class UserRepository implements IUserRepository {
  /// Инициализирует репозиторий с зависимостью от [UserApi]
  /// [UserApi userApi] - API клиент для выполнения запросов
  UserRepository({required UserApi userApi}) : _userApi = userApi;

  @override
  final ValueNotifier<UserDto?> userNotifier = ValueNotifier<UserDto?>(null);

  final UserApi _userApi;

  @override
  Future<void> getCurrentUser() async {
    final u = await _userApi.getCurrentUser();
    userNotifier.value = u;
  }

  @override
  Future<UserDto> getUserById(int userId) async {
    return _userApi.getUserById(userId);
  }

  @override
  Future<UserSearchResponse> searchUsers({String? login, String? relationType, int? limit, int? offset}) async {
    final request = UserSearchRequest(login: login, relationType: relationType, limit: limit, offset: offset);
    return _userApi.searchUsers(request);
  }
}
