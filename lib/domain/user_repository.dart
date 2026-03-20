import 'package:showcase_project/data/api/api/user_api.dart';
import 'package:showcase_project/data/models/remote/dto/user/user_with_profile_dto.dart';
import 'package:showcase_project/data/models/remote/request/user_search/user_search_request.dart';
import 'package:showcase_project/data/models/remote/response/user_search/user_search_response.dart';

/// Интерфейс репозитория для работы с пользователями
abstract interface class IUserRepository {
  /// Получает профиль текущего пользователя с данными профиля
  Future<UserWithProfileDto> getCurrentUser();

  /// Получает профиль другого пользователя по ID
  Future<UserWithProfileDto> getUserById(int userId);

  /// Ищет пользователей с пагинацией и фильтрацией
  Future<UserSearchResponse> searchUsers({String? login, String? relationType, int? limit, int? offset});
}

/// Репозиторий для работы с пользователями
/// Скрывает детали реализации API от UI слоя
class UserRepository implements IUserRepository {
  /// Инициализирует репозиторий с зависимостью от [UserApi]
  /// [UserApi userApi] - API клиент для выполнения запросов
  UserRepository({required UserApi userApi}) : _userApi = userApi;

  final UserApi _userApi;

  @override
  Future<UserWithProfileDto> getCurrentUser() async {
    return _userApi.getCurrentUser();
  }

  @override
  Future<UserWithProfileDto> getUserById(int userId) async {
    return _userApi.getUserById(userId);
  }

  @override
  Future<UserSearchResponse> searchUsers({String? login, String? relationType, int? limit, int? offset}) async {
    final request = UserSearchRequest(login: login, relationType: relationType, limit: limit, offset: offset);
    return _userApi.searchUsers(request);
  }
}
