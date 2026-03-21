import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';
import 'package:showcase_project/di/octopus_helper/octopus_scope_helper.dart';
import 'package:showcase_project/features/screens/add_habbit/add_habbit_view.dart';
import 'package:showcase_project/features/screens/auth/auth_view.dart';
import 'package:showcase_project/features/screens/home/home_view.dart';
import 'package:showcase_project/features/screens/profile/profile_view.dart';

/// Перечисление всех доступных маршрутов в приложении
/// Использует миксин [OctopusRoute] для интеграции с пакетом маршрутизации octopus
enum Routes with OctopusRoute {
  /// Экран добавления новой привычки
  addHabbit('addHabbit'),

  /// Экран авторизации и регистрации
  auth('auth'),

  /// Главный экран приложения
  home('home'),

  /// Экран профиля пользователя
  profile('profile'),

  /// Экран настроек приложения
  settings('settings');

  // ignore: unused_element, unused_element_parameter
  const Routes(this.name, {this.title});

  /// Системное имя маршрута, используется для URL и внутреннего представления
  @override
  final String name;

  /// Человекочитаемое название маршрута (опционально)
  @override
  final String? title;

  /// Метод-строитель, возвращающий виджет для каждого конкретного маршрута
  /// [BuildContext context] - контекст сборки
  /// [OctopusState state] - текущее состояние маршрутизатора
  /// [OctopusNode node] - текущий узел маршрутизации
  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) => switch (this) {
    Routes.addHabbit => AddHabbitView(),
    Routes.auth => AuthScopeWrapper(child: AuthView()),
    Routes.home => HomeView(),
    Routes.profile => ProfileView(),
    Routes.settings => const Text('Settings'),
  };
}
