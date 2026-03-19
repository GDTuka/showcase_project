import 'package:dio/dio.dart';
import 'package:showcase_project/data/models/remote/request/check_unique/check_unique_request.dart';
import 'package:showcase_project/data/models/remote/request/login/login_request.dart';
import 'package:showcase_project/data/models/remote/request/register/register_request.dart';

/// Абстракция сервиса для работы с API авторизации.
///
/// Скрывает детали реализации сетевых запросов и облегчает подмену
/// реализации (например, для моков в тестах).
abstract class IAuthApi {
  /// Регистрирует нового пользователя.
  ///
  /// [request] — данные для регистрации.
  /// Возвращает сырое [Response] от сервера.
  Future<Response> register(RegisterRequest request);

  /// Авторизует существующего пользователя.
  ///
  /// [request] — данные для входа.
  /// Возвращает сырое [Response] от сервера.
  Future<Response> login(LoginRequest request);

  /// Проверяет уникальность логина.
  ///
  /// [login] — логин для проверки.
  /// Возвращает `true`, если логин уникален.
  Future<bool> checkLoginUnique(String login);

  /// Проверяет уникальность номера телефона.
  ///
  /// [phone] — номер телефона для проверки.
  /// Возвращает `true`, если номер уникален.
  Future<bool> checkPhoneUnique(String phone);

  /// Проверяет доступность сервера.
  ///
  /// Возвращает `true`, если сервер отвечает ожидаемым образом.
  Future<bool> ping();
}

/// Реализация [IAuthApi] на базе HTTP‑клиента [Dio].
///
/// Инкапсулирует детали формирования запросов и обработки ошибок.
class AuthApi implements IAuthApi {
  /// Клиент для сетевых запросов.
  final Dio _dio;

  /// Создаёт экземпляр [AuthApi] с внедрённым [Dio].
  AuthApi({required Dio dio}) : _dio = dio;

  @override
  Future<Response> register(RegisterRequest request) async {
    try {
      final response = await _dio.post('/auth/register', data: request.toJson());
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> login(LoginRequest request) async {
    try {
      final response = await _dio.post('/auth/login', data: request.toJson());
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<bool> checkLoginUnique(String login) async {
    try {
      final request = CheckUniqueRequest(value: login);
      final response = await _dio.post(
        '/utils/login-unique',
        data: request.toJson(),
      );
      return response.data['is_unique'] as bool;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<bool> checkPhoneUnique(String phone) async {
    try {
      final request = CheckUniqueRequest(value: phone);
      final response = await _dio.post(
        '/utils/phone-unique',
        data: request.toJson(),
      );
      return response.data['is_unique'] as bool;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<bool> ping() async {
    try {
      final response = await _dio.get('/ping');
      return response.data['message'] == 'pong';
    } catch (_) {
      return false;
    }
  }

  /// Обрабатывает ошибки [DioException] и преобразует их в более понятные исключения.
  Exception _handleError(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['error'] != null) {
      return Exception(data['error']);
    }
    return Exception(e.message ?? 'Unknown API Error');
  }
}
