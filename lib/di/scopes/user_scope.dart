import 'package:flutter/material.dart';
import 'package:padi/padi.dart';

class UserScope extends Padi {
  @override
  Future<void> initAsync(BuildContext context) async {}
}

/// Расширение для быстрого доступа к [UserScope] из [BuildContext]
extension HabitScopeExtension on BuildContext {
  /// Возвращает экземпляр [UserScope], привязанный к текущему контексту
  UserScope get user => PadiScope.of<UserScope>(this);
}
