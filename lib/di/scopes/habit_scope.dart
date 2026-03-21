import 'package:flutter/material.dart';
import 'package:padi/padi.dart';
import 'package:showcase_project/data/api/api/habbit_api.dart';
import 'package:showcase_project/di/scopes/global_scope.dart';
import 'package:showcase_project/domain/habbit_repository.dart';

class HabitScope extends Padi {
  late final IHabbitRepository habbitRepository;

  late final HabbitApi _habbitApi;

  @override
  Future<void> initAsync(BuildContext context) async {
    _habbitApi = HabbitApi(dio: context.global.dio);

    habbitRepository = HabbitRepository(habbitApi: _habbitApi);
  }
}

/// Расширение для быстрого доступа к [HabitScope] из [BuildContext]
extension HabitScopeExtension on BuildContext {
  /// Возвращает экземпляр [HabitScope], привязанный к текущему контексту
  HabitScope get habit => PadiScope.of<HabitScope>(this);
}
