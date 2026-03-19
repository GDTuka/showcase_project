import 'dart:async';

import 'package:octopus/octopus.dart';
import 'package:showcase_project/data/storage/jwt_storage.dart';
import 'package:showcase_project/features/navigation/router.dart';

/// Гард для защиты маршрутов, требующих авторизации.
///
/// Использует [JWTStorage] для чтения сохранённого JWT.
/// Если токен не найден, пользователь перенаправляется на [Routes.auth].
/// Если токен существует, исходная навигация продолжается без изменений.
class AuthGuard extends OctopusGuard {
  AuthGuard({required JWTStorage jwtStorage}) : _jwtStorage = jwtStorage;

  /// Хранилище, используемое для чтения текущего JWT access‑токена.
  final JWTStorage _jwtStorage;

  @override
  /// Проверяет наличие сохранённого токена и перенаправляет
  /// неавторизованных пользователей на экран авторизации.
  FutureOr<OctopusState> call(
    List<OctopusHistoryEntry> history,
    OctopusState$Mutable state,
    Map<String, Object?> context,
  ) async {
    final token = await _jwtStorage.getToken();

    if (token == null) {
      return OctopusState(
        children: [
          OctopusNode(
            name: Routes.auth.name,
            arguments: const {},
            children: const [],
          ),
        ],
        arguments: const {},
        intention: OctopusStateIntention.navigate,
      );
    }

    // Пользователь авторизован: оставляем запрошенное состояние без изменений.
    return state;
  }
}
