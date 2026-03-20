import 'package:dio/dio.dart';
import 'package:showcase_project/data/storage/jwt_storage.dart';

/// Интерсептор для автоматической добавления JWT токена в заголовки запросов
class JwtInterceptor extends Interceptor {
  /// Создает интерсептор с зависимостью от token service
  JwtInterceptor({required IJWTStorage tokenService}) : _jwtStorage = tokenService;

  /// Сервис для работы с токенами
  final IJWTStorage _jwtStorage;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Получаем текущий токен из domain слоя
    final token = await _jwtStorage.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Если ошибка 401 (Unauthorized), возможно токен истек
    if (err.response?.statusCode == 401) {
      // TODO: Здесь можно добавить логику обновления токена через domain слой
      // или перенаправления на экран логина
    }

    super.onError(err, handler);
  }
}
