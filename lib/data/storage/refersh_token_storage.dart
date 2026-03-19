import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Интерфейс для хранения Refresh токенов
/// Определяет контракт для операций с токенами обновления
abstract class IRefreshTokenStorage {
  /// Сохраняет Refresh токен в защищенное хранилище
  /// [token] - Refresh токен для сохранения
  Future<void> writeToken(String token);

  /// Получает сохраненный Refresh токен из хранилища
  /// Возвращает токен или пустую строку, если токен не найден
  Future<String?> getToken();

  /// Удаляет Refresh токен из хранилища
  Future<void> deleteToken();
}

/// Реализация хранилища Refresh токенов
/// Использует FlutterSecureStorage для безопасного хранения токенов обновления
class RefreshTokenStorage implements IRefreshTokenStorage {
  /// Создает экземпляр хранилища Refresh токенов
  /// [storage] - экземпляр FlutterSecureStorage для работы с защищенным хранилищем
  RefreshTokenStorage({required FlutterSecureStorage storage}) : _storage = storage;

  /// Экземпляр защищенного хранилища
  late final FlutterSecureStorage _storage;

  /// Ключ для хранения Refresh токена
  final String _key = 'refresh_token';

  /// Сохраняет Refresh токен в защищенное хранилище
  /// Если токен уже существует, он будет перезаписан
  /// [token] - Refresh токен для сохранения
  @override
  Future<void> writeToken(String token) async {
    final existingToken = await _storage.read(key: _key);

    if (existingToken != null) {
      await _storage.delete(key: _key);
    }

    await _storage.write(key: _key, value: token);
  }

  /// Получает сохраненный Refresh токен из хранилища
  /// Возвращает токен или пустую строку, если токен не найден
  @override
  Future<String?> getToken() async {
    final token = await _storage.read(key: _key);
    return token;
  }

  /// Удаляет Refresh токен из хранилища
  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: _key);
  }
}
