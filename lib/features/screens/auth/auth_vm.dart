import 'package:evvm/evvm.dart';
import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/screens/auth/auth_widget.dart';
import 'package:showcase_project/features/utils/app_text_field/text_field_controller.dart';

/// Интерфейс ViewModel для экрана авторизации и регистрации
/// Содержит все необходимые свойства и методы для управления состоянием экрана
abstract interface class IAuthVm implements IViewModel {
  /// Контроллер для поля ввода номера телефона
  AppTextController get phoneController;

  /// Контроллер для поля ввода СМС кода
  AppTextController get codeController;

  /// Состояние загрузки во время сетевых запросов
  EntityValueListenable<bool> get isLoadingListenable;

  /// Состояние, указывающее был ли уже отправлен СМС код на номер телефона
  /// Если true - показываем поле ввода кода, если false - поле ввода телефона
  EntityValueListenable<bool> get isCodeSentListenable;

  /// Метод для отправки данных (номера телефона или СМС кода)
  Future<void> submit();
}

/// Фабрика для создания экземпляра [AuthVm]
/// Вызывается при создании виджета [AuthWidget]
AuthVm authVMF(BuildContext context) {
  return AuthVm();
}

/// Реализация ViewModel для экрана авторизации
/// Управляет бизнес-логикой авторизации по номеру телефона
class AuthVm extends ViewModel<AuthWidget> implements IAuthVm {
  /// Инициализация контроллера телефона с маской
  late final _phoneController = AppTextController(label: 'Номер телефона', mask: '+7(###)###-##-##');

  /// Инициализация контроллера кода с маской
  late final _codeController = AppTextController(label: 'Код из СМС', mask: '######');

  /// Внутреннее состояние загрузки
  final _isLoadingEntity = EntityStateNotifier<bool>.value(false);

  /// Внутреннее состояние отправленного кода
  final _isCodeSentEntity = EntityStateNotifier<bool>.value(false);

  @override
  AppTextController get phoneController => _phoneController;

  @override
  AppTextController get codeController => _codeController;

  @override
  EntityValueListenable<bool> get isLoadingListenable => _isLoadingEntity;

  @override
  EntityValueListenable<bool> get isCodeSentListenable => _isCodeSentEntity;

  @override
  void init() {
    super.init();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _isLoadingEntity.dispose();
    _isCodeSentEntity.dispose();
    super.dispose();
  }

  @override
  Future<void> submit() async {
    // Предотвращение множественных нажатий во время загрузки
    if (_isLoadingEntity.value.data ?? false) return;

    // Установка состояния загрузки
    _isLoadingEntity.content(true);

    // Имитация сетевого запроса
    await Future.delayed(const Duration(seconds: 2));

    if (!(_isCodeSentEntity.value.data ?? false)) {
      // Если код еще не был отправлен:
      // 1. Помечаем, что код отправлен (переключает UI на ввод кода)
      // 2. Снимаем состояние загрузки
      _isCodeSentEntity.content(true);
      _isLoadingEntity.content(false);
    } else {
      // Если код уже отправлен и мы его проверяем:
      // 1. Завершаем загрузку
      // 2. В будущем здесь будет навигация на главный экран
      _isLoadingEntity.content(false);
      // TODO: Навигация после успешной авторизации
    }
  }
}
