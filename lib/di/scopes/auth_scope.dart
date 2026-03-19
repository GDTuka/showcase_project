import 'package:flutter/material.dart';
import 'package:padi/padi.dart';
import 'package:showcase_project/data/api/api/auth_api.dart';
import 'package:showcase_project/di/scopes/global_scope.dart';
import 'package:showcase_project/domain/auth_repository.dart';

/// Область видимости для зависимостей авторизации.
///
/// Отвечает за создание и конфигурацию репозитория авторизации [IAuthRepository]
/// и API‑клиента [IAuthApi], инкапсулируя детали их инициализации.
class AuthScope extends Padi {
  /// Репозиторий для работы с авторизацией.
  ///
  /// Скрывает детали сетевого API от UI слоя и управляет
  /// сохранением/чтением токенов аутентификации.
  late final IAuthRepository authRepository;

  /// API‑клиент для работы с эндпоинтами авторизации.
  ///
  /// Описывает низкоуровневые HTTP‑запросы к бэкенду.
  late final IAuthApi authApi;

  /// Асинхронная инициализация зависимостей авторизации.
  ///
  /// Метод вызывается фреймворком DI один раз при создании области.
  /// Здесь получаем необходимые зависимости из [GlobalScope] и
  /// конструируем конкретные реализации [IAuthApi] и [IAuthRepository].
  @override
  Future<void> initAsync(BuildContext context) async {
    final global = context.global;

    authApi = AuthApi(dio: global.dio);

    authRepository = AuthRepository(
      authApi: authApi,
      jwtStorage: global.jwtStorage,
      refreshTokenStorage: global.refreshTokenStorage,
    );
  }
}

/// Расширение для быстрого доступа к [AuthScope] из [BuildContext]
extension AuthScopeExtension on BuildContext {
  /// Возвращает экземпляр [AuthScope], привязанный к текущему контексту
  AuthScope get auth => PadiScope.of<AuthScope>(this);
}
