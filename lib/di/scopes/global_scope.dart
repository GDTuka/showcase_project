import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';
import 'package:padi/padi.dart';
import 'package:showcase_project/features/navigation/router.dart';

/// Глобальная область видимости для зависимостей приложения
/// Содержит все сервисы и контроллеры, которые должны жить на протяжении всего жизненного цикла приложения
/// Наследуется от [Padi] для интеграции с DI
class GlobalScope extends Padi {
  /// Роутер приложения для управления навигацией
  late Octopus router;

  /// Асинхронная инициализация глобальных зависимостей
  /// Вызывается при запуске приложения до показа основного экрана
  /// [BuildContext context] - контекст приложения
  @override
  Future<void> initAsync(BuildContext context) async {
    // Инициализация роутера со списком доступных маршрутов
    router = Octopus(routes: Routes.values);
  }
}

/// Расширение для быстрого доступа к [GlobalScope] из [BuildContext]
extension GlobalScopeExtension on BuildContext {
  /// Возвращает экземпляр [GlobalScope], привязанный к текущему контексту
  GlobalScope get global => PadiScope.of<GlobalScope>(this);
}
