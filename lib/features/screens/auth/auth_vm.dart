import 'package:evvm/evvm.dart';
import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/domain/auth_repository.dart';
import 'package:showcase_project/di/scopes/global_scope.dart';
import 'package:showcase_project/features/screens/auth/auth_view.dart';
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
/// Вызывается при создании виджета [AuthView]
AuthVm authVMF(BuildContext context) {
  return AuthVm(authRepository: context.global.authRepository);
}

/// Реализация ViewModel для экрана авторизации
/// Управляет бизнес-логикой авторизации по номеру телефона
class AuthVm extends ViewModel<AuthView> implements IAuthVm {
  /// Инициализирует ViewModel и принимает зависимости
  /// [IAuthRepository authRepository] - репозиторий для работы с авторизацией
  AuthVm({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  /// Репозиторий авторизации
  final IAuthRepository _authRepository;

  /// Инициализация контроллера телефона с маской
  late final _phoneController = AppTextController(
    label: 'Номер телефона',
    mask: '+7(###)###-##-##',
  );

  /// Инициализация контроллера кода с маской
  late final _codeController = AppTextController(
    label: 'Код из СМС',
    mask: '######',
  );

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

    try {
      if (!(_isCodeSentEntity.value.data ?? false)) {
        // Получаем сырой номер телефона без маски
        final phone = _phoneController.unmasked;

        // 1. Проверяем, существует ли уже такой номер
        await _authRepository.checkPhoneUnique(phone);

        // В реальном приложении здесь была бы логика отправки СМС,
        // но так как API бэкенда принимает пароль при логине/регистрации,
        // будем использовать СМС код как "пароль" для демонстрации.

        // Помечаем, что код отправлен (переключает UI на ввод кода)
        _isCodeSentEntity.content(true);
      } else {
        // Если код уже введен:
        final phone = _phoneController.unmasked;
        final password = _codeController.unmasked; // Используем код как пароль

        // Проверяем уникальность еще раз, чтобы решить: логин или регистрация
        final isUnique = await _authRepository.checkPhoneUnique(phone);

        if (isUnique) {
          // Если номер уникален - регистрируем
          // Генерируем случайный логин, так как в UI его нет
          final login = 'user_$phone';
          await _authRepository.register(
            login: login,
            phone: phone,
            password: password,
          );

          // После регистрации сразу логинимся
          await _authRepository.login(login: login, password: password);
        } else {
          // Если номер НЕ уникален - значит пользователь уже существует, логинимся
          // Для логина нужен login, но в UI у нас только телефон.
          // Предполагаем, что логин совпадает с 'user_$phone'
          final login = 'user_$phone';
          await _authRepository.login(login: login, password: password);
        }

        // TODO: Навигация после успешной авторизации на главный экран
      }
    } catch (e) {
      // В случае ошибки показываем ее в поле
      if (!(_isCodeSentEntity.value.data ?? false)) {
        _phoneController.updateFieldState(FieldStateType.error, e.toString());
      } else {
        _codeController.updateFieldState(FieldStateType.error, e.toString());
      }
    } finally {
      // Снимаем состояние загрузки в любом случае
      _isLoadingEntity.content(false);
    }
  }
}
