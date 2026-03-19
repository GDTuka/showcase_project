import 'package:dio/dio.dart';
import 'package:l/l.dart';

/// Интецептор для логирования сетевых запросов через пакет l
/// Использует стандартные терминальные цвета (зеленый для успеха, красный для ошибок)
class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    l.i('╔═══════════════════════════════════════════════════');
    l.i('║ 🌐 [REQUEST] ${options.method} ${options.uri}');

    if (options.headers.isNotEmpty) {
      l.i('║ 📋 [HEADERS]:');
      options.headers.forEach((key, value) {
        l.i('║    $key: $value');
      });
    }

    if (options.data != null) {
      l.i('║ 📦 [BODY]:');
      l.i('║    ${options.data}');
    }

    l.i('╚═══════════════════════════════════════════════════');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    l.s('╔═══════════════════════════════════════════════════');
    l.s(
      '║ ✅ [RESPONSE] ${response.requestOptions.method} ${response.requestOptions.uri}',
    );
    l.s('║ 📊 [STATUS]: ${response.statusCode}');

    if (response.headers.map.isNotEmpty) {
      l.s('║ 📋 [HEADERS]:');
      response.headers.map.forEach((key, value) {
        l.s('║    $key: ${value.join(', ')}');
      });
    }

    if (response.data != null) {
      l.s('║ 📦 [BODY]:');
      l.s('║    ${response.data}');
    }

    l.s('╚═══════════════════════════════════════════════════');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    l.e('╔═══════════════════════════════════════════════════');
    l.e('║ ❌ [ERROR] ${err.requestOptions.method} ${err.requestOptions.uri}');
    l.e('║ 📊 [STATUS]: ${err.response?.statusCode}');
    l.e('║ 🚨 [MESSAGE]: ${err.message}');

    if (err.response?.data != null) {
      l.e('║ 📦 [RESPONSE BODY]:');
      l.e('║    ${err.response?.data}');
    }

    l.e('╚═══════════════════════════════════════════════════');
    super.onError(err, handler);
  }
}
