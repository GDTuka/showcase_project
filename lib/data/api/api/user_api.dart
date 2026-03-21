import 'package:dio/dio.dart';
import 'package:showcase_project/data/models/remote/models.dart';

/// Сервис для работы с API пользователей
class UserApi {
  /// Инициализирует сервис с внедренным клиентом [Dio]
  /// [Dio dio] - настроенный клиент для выполнения сетевых запросов
  UserApi({required Dio dio}) {
    _dio = dio;
  }

  /// Клиент для сетевых запросов
  late final Dio _dio;

  /// Отправляет СМС код текущему пользователю
  Future<void> sendSmsCode({required String phone, required SmsCodeType type}) async {
    try {
      await _dio.post('/user/sms/send', data: {'phone': phone, 'type': type.name});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Проверяет СМС код
  /// [SmsCheckRequest request] - данные для проверки кода
  Future<bool> checkSmsCode(SmsCheckRequest request) async {
    try {
      final res = await _dio.post('/user/sms/check', data: request.toJson());
      return res.data['success'];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Получает профиль текущего пользователя с данными профиля
  Future<UserDto> getCurrentUser() async {
    try {
      final response = await _dio.get('/user/me');
      return UserDto.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Получает профиль другого пользователя по ID
  /// [int userId] - ID пользователя
  Future<UserDto> getUserById(int userId) async {
    try {
      final response = await _dio.get('/user/$userId');
      return UserDto.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Ищет пользователей с пагинацией и фильтрацией
  /// [UserSearchRequest request] - параметры поиска
  Future<UserSearchResponse> searchUsers(UserSearchRequest request) async {
    try {
      final response = await _dio.get('/user/search', queryParameters: request.toQueryParams());
      return UserSearchResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Обрабатывает ошибки Dio и преобразует их в понятные исключения
  Exception _handleError(DioException e) {
    if (e.response?.data != null && e.response?.data['error'] != null) {
      return Exception(e.response?.data['error']);
    }
    return Exception(e.message ?? 'Unknown API Error');
  }
}
