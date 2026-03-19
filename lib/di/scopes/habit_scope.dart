import 'package:flutter/material.dart';
import 'package:padi/padi.dart';

class HabitScope extends Padi {
  @override
  Future<void> initAsync(BuildContext context) async {}
}

/// Расширение для быстрого доступа к [HabitScope] из [BuildContext]
extension HabitScopeExtension on BuildContext {
  /// Возвращает экземпляр [HabitScope], привязанный к текущему контексту
  HabitScope get habit => PadiScope.of<HabitScope>(this);
}
