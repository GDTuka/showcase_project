import 'dart:async';

import 'package:flutter/material.dart';
import 'package:padi/padi.dart';
import 'package:showcase_project/app/app.dart';
import 'package:showcase_project/di/scopes/global_scope.dart';
import 'package:showcase_project/features/utils/flavor.dart';
import 'package:showcase_project/features/widgets/scopes_widgets/scope_error_widget.dart';
import 'package:showcase_project/features/widgets/scopes_widgets/scope_loader_widget.dart';

/// Запускает приложение с перехватом всех необработанных ошибок
/// Используется в файлах-лаунчерах (main.dart и т.д.) для инициализации приложения
/// [FlavorConfig cfg] - конфигурация окружения для запуска (dev, prod, stage)
void runner(FlavorConfig cfg) {
  runZonedGuarded(
    () {
      // Инициализация и запуск основного виджета приложения
      // PadiWidget используется для внедрения зависимостей на уровне всего приложения
      runApp(
        PadiWidget(
          create: GlobalScope.new,
          loaderBuilder: (context) => ScopeLoaderWidget(),
          errorBuilder: (context) => ScopeErrorWidget(),
          child: App(),
        ),
      );
    },
    (error, stack) {
      // Обработка необработанных ошибок приложения
    },
  );
}
