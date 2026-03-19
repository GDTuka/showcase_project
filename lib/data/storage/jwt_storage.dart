import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Интерфейс для хранения JWT токенов
/// Определяет контракт для операций с токенами авторизации
abstract class IJWTStorage {
  /// Сохраняет JWT токен в защищенное хранилище
  /// [token] - JWT токен для сохранения
  Future<void> writeToken(String token);

  /// Получает сохраненный JWT токен из хранилища
  /// Возвращает токен или пустую строку, если токен не найден
  Future<String?> getToken();

  /// Удаляет JWT токен из хранилища
  Future<void> deleteToken();
}

/// Реализация хранилища JWT токенов
/// Использует FlutterSecureStorage для безопасного хранения токенов
class JWTStorage implements IJWTStorage {
  /// Создает экземпляр хранилища JWT токенов
  /// [storage] - экземпляр FlutterSecureStorage для работы с защищенным хранилищем
  JWTStorage({required FlutterSecureStorage storage}) : _storage = storage;

  /// Экземпляр защищенного хранилища
  late final FlutterSecureStorage _storage;

  /// Ключ для хранения JWT токена
  final String _key = 'jwt_token';

  /// Сохраняет JWT токен в защищенное хранилище
  /// Если токен уже существует, он будет перезаписан
  /// [token] - JWT токен для сохранения
  @override
  Future<void> writeToken(String token) async {
    final existingToken = await _storage.read(key: _key);

    if (existingToken != null) {
      await _storage.delete(key: _key);
    }

    await _storage.write(key: _key, value: token);
  }

  /// Получает сохраненный JWT токен из хранилища
  /// Возвращает токен или пустую строку, если токен не найден
  @override
  Future<String?> getToken() async {
    final token = await _storage.read(key: _key);
    return token;
  }

  /// Удаляет JWT токен из хранилища
  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: _key);
  }
}
