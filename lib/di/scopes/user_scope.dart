import 'package:flutter/material.dart';
import 'package:padi/padi.dart';
import 'package:showcase_project/data/api/api/user_api.dart';
import 'package:showcase_project/di/scopes/global_scope.dart';
import 'package:showcase_project/domain/user_repository.dart';

class UserScope extends Padi {
  late final IUserRepository userRepository;

  late final UserApi _userApi;

  @override
  Future<void> initAsync(BuildContext context) async {
    _userApi = UserApi(dio: context.global.dio);

    userRepository = UserRepository(userApi: _userApi);

    try {
      userRepository.getCurrentUser();
    } on Object {
      throw Exception();
    }
  }
}

/// Расширение для быстрого доступа к [UserScope] из [BuildContext]
extension HabitScopeExtension on BuildContext {
  /// Возвращает экземпляр [UserScope], привязанный к текущему контексту
  UserScope get user => PadiScope.of<UserScope>(this);
}
