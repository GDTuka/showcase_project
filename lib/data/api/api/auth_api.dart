import 'package:dio/dio.dart';
import 'package:showcase_project/data/models/remote/request/check_unique/check_unique_request.dart';
import 'package:showcase_project/data/models/remote/request/login/login_request.dart';
import 'package:showcase_project/data/models/remote/request/register/register_request.dart';

/// Сервис для работы с API авторизации
class AuthApi {
  /// Инициализирует сервис с внедренным клиентом [Dio]
  /// [Dio dio] - настроенный клиент для выполнения сетевых запросов
  AuthApi({required Dio dio}) {
    _dio = dio;
  }

  /// Клиент для сетевых запросов
  late final Dio _dio;

  /// Регистрирует нового пользователя
  /// [RegisterRequest request] - данные для регистрации
  /// Возвращает ID созданного пользователя
  Future<Response> register(RegisterRequest request) async {
    try {
      final response = await _dio.post('/auth/register', data: request.toJson());

      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Авторизует существующего пользователя
  /// [LoginRequest request] - данные для входа
  /// Возвращает модель пользователя
  Future<Response> login(LoginRequest request) async {
    try {
      final response = await _dio.post('/auth/login', data: request.toJson());

      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Проверяет уникальность логина
  /// [String login] - логин для проверки
  /// Возвращает true, если логин уникален
  Future<bool> checkLoginUnique(String login) async {
    try {
      final request = CheckUniqueRequest(value: login);
      final response = await _dio.post('/utils/login-unique', data: request.toJson());

      return response.data['is_unique'] as bool;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Проверяет уникальность номера телефона
  /// [String phone] - телефон для проверки
  /// Возвращает true, если телефон уникален
  Future<bool> checkPhoneUnique(String phone) async {
    try {
      final request = CheckUniqueRequest(value: phone);
      final response = await _dio.post('/utils/phone-unique', data: request.toJson());

      return response.data['is_unique'] as bool;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Проверяет доступность сервера
  Future<bool> ping() async {
    try {
      final response = await _dio.get('/ping');
      return response.data['message'] == 'pong';
    } catch (_) {
      return false;
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
