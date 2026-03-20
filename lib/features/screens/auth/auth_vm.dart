import 'package:dio/dio.dart';
import 'package:evvm/evvm.dart';
import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:overlay_notifications/overlay_notifications.dart';
import 'package:showcase_project/di/scopes/auth_scope.dart';
import 'package:showcase_project/di/scopes/global_scope.dart';
import 'package:showcase_project/domain/auth_repository.dart';
import 'package:showcase_project/domain/sms_repository.dart';
import 'package:showcase_project/features/screens/auth/auth_view.dart';
import 'package:showcase_project/features/utils/app_text_field/text_field_controller.dart';
import 'package:showcase_project/features/widgets/overlay_notification/overlay_notification_widget.dart';

/// Интерфейс ViewModel для экрана авторизации и регистрации
/// Содержит все необходимые свойства и методы для управления состоянием экрана
abstract interface class IAuthVm implements IViewModel {
  /// Контроллер для поля ввода номера телефона при авторизации
  AppTextController get authPhoneController;

  /// Контроллер для поля ввода номера телефона при регистрации
  AppTextController get regPhoneController;

  /// Контроллер для поля ввода СМС кода при авторизации
  AppTextController get authCodeController;

  /// Контроллер для поля ввода СМС кода при регистрации
  AppTextController get regCodeController;

  /// Контроллер для поля ввода логина
  AppTextController get loginController;

  /// Состояние загрузки во время сетевых запросов
  EntityValueListenable<bool> get isLoadingListenable;

  /// Состояние, указывающее был ли уже отправлен СМС код на номер телефона
  /// Если true - показываем поле ввода кода, если false - поле ввода телефона
  EntityValueListenable<bool> get isCodeSentListenable;

  /// Состояние режима: true - Авторизация, false - Регистрация
  EntityValueListenable<bool> get isLoginModeListenable;

  ///
  EntityValueListenable<String?> get errorListenable;

  ///
  EntityValueListenable<bool> get sendCodeButtonEnableListenable;

  /// Метод для отправки данных (номера телефона или СМС кода)
  Future<void> submit();

  /// Переключает режим между Авторизацией и Регистрацией
  void toggleMode();
}

/// Фабрика для создания экземпляра [AuthVm]
/// Вызывается при создании виджета [AuthView]
AuthVm authVMF(BuildContext context) {
  return AuthVm(authRepository: context.auth.authRepository, smsRepository: context.global.smsRepository);
}

/// Реализация ViewModel для экрана авторизации
/// Управляет бизнес-логикой авторизации по номеру телефона
class AuthVm extends ViewModel<AuthView> implements IAuthVm {
  /// Инициализирует ViewModel и принимает зависимости
  /// [IAuthRepository authRepository] - репозиторий для работы с авторизацией
  AuthVm({required IAuthRepository authRepository, required ISmsRepository smsRepository})
    : _authRepository = authRepository,
      _smsRepository = smsRepository;

  /// Репозиторий авторизации
  final IAuthRepository _authRepository;

  final ISmsRepository _smsRepository;

  /// Инициализация контроллера телефона для авторизации
  late final _authPhoneController = AppTextController(
    label: 'Номер телефона',
    mask: '+7(###)###-##-##',
    validator: _validatePhone,
  );

  /// Инициализация контроллера телефона для регистрации
  late final _regPhoneController = AppTextController(
    label: 'Номер телефона',
    mask: '+7(###)###-##-##',
    validator: _validatePhone,
  );

  /// Инициализация контроллера кода для авторизации
  late final _authCodeController = AppTextController(label: 'Код из СМС', mask: '######', validator: _validateCode);

  /// Инициализация контроллера кода для регистрации
  late final _regCodeController = AppTextController(label: 'Код из СМС', mask: '######', validator: _validateCode);

  /// Инициализация контроллера логина
  late final _loginController = AppTextController(label: 'Логин (только русские буквы)', validator: _validateLogin);

  /// Внутреннее состояние загрузки
  final _isLoadingEntity = EntityStateNotifier<bool>.value(false);

  /// Внутреннее состояние отправленного кода
  final _isCodeSentEntity = EntityStateNotifier<bool>.value(false);

  /// Внутреннее состояние режима
  final _isLoginModeEntity = EntityStateNotifier<bool>.value(true);

  final _errorEntity = EntityStateNotifier<String?>.value(null);

  final _sendCodeButtonEnableEntity = EntityStateNotifier.value(false);

  @override
  AppTextController get authPhoneController => _authPhoneController;

  @override
  AppTextController get regPhoneController => _regPhoneController;

  @override
  AppTextController get authCodeController => _authCodeController;

  @override
  AppTextController get regCodeController => _regCodeController;

  @override
  AppTextController get loginController => _loginController;

  @override
  EntityValueListenable<bool> get isLoadingListenable => _isLoadingEntity;

  @override
  EntityValueListenable<bool> get isCodeSentListenable => _isCodeSentEntity;

  @override
  EntityValueListenable<bool> get isLoginModeListenable => _isLoginModeEntity;

  @override
  EntityValueListenable<String?> get errorListenable => _errorEntity;

  @override
  EntityValueListenable<bool> get sendCodeButtonEnableListenable => _sendCodeButtonEnableEntity;

  Future<ValidatorResponse> _validatePhone(String? value) async {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) {
      _sendCodeButtonEnableEntity.content(false);
      return ValidatorResponse(FieldStateType.none);
    }
    if (digits.length < 10) {
      _sendCodeButtonEnableEntity.content(false);
      return ValidatorResponse(FieldStateType.error, message: 'Неполный номер телефона');
    }
    _sendCodeButtonEnableEntity.content(true);
    return ValidatorResponse(FieldStateType.success);
  }

  Future<ValidatorResponse> _validateCode(String? value) async {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) {
      return ValidatorResponse(FieldStateType.none);
    }
    if (digits.length < 6) {
      return ValidatorResponse(FieldStateType.error, message: 'Введите 6-значный код');
    }
    _sendCodeButtonEnableEntity.content(true);
    return ValidatorResponse(FieldStateType.success);
  }

  Future<ValidatorResponse> _validateLogin(String? value) async {
    if (value == null || value.isEmpty) {
      return ValidatorResponse(FieldStateType.none);
    }

    final regExp = RegExp(r'^[а-яА-ЯёЁ]+$');
    if (!regExp.hasMatch(value)) {
      return ValidatorResponse(FieldStateType.error, message: 'Только русские буквы без спецсимволов и пробелов');
    }

    if (value.length < 3 || value.length > 30) {
      return ValidatorResponse(FieldStateType.error, message: 'Логин должен содержать от 3 до 30 символов');
    }

    return ValidatorResponse(FieldStateType.success);
  }

  @override
  void init() {
    super.init();
    _authPhoneController.addListener(_onAuthPhoneChanged);
    _regPhoneController.addListener(_onRegPhoneChanged);
    _loginController.addListener(_onRegLoginChanged);
    _authCodeController.addListener(_onAuthCodeChanged);
    _regCodeController.addListener(_onRegCodeChanged);
  }

  @override
  void dispose() {
    _authPhoneController.removeListener(_onAuthPhoneChanged);
    _regPhoneController.removeListener(_onRegPhoneChanged);
    _loginController.removeListener(_onRegLoginChanged);
    _authCodeController.removeListener(_onAuthCodeChanged);
    _regCodeController.removeListener(_onRegCodeChanged);

    _authPhoneController.dispose();
    _regPhoneController.dispose();
    _authCodeController.dispose();
    _regCodeController.dispose();
    _loginController.dispose();

    _isLoadingEntity.dispose();
    _isCodeSentEntity.dispose();
    _isLoginModeEntity.dispose();
    super.dispose();
  }

  @override
  void toggleMode() {
    final currentMode = _isLoginModeEntity.value.data ?? true;
    _isLoginModeEntity.content(!currentMode);
    _isCodeSentEntity.content(false);
    _authCodeController.clear();
    _regCodeController.clear();
    _authCodeController.updateFieldState(FieldStateType.none, '');
    _regCodeController.updateFieldState(FieldStateType.none, '');
  }

  void _onAuthPhoneChanged() {
    if (!(_isLoginModeEntity.value.data ?? true)) return;
    if (!(_isCodeSentEntity.value.data ?? false)) {
      final unmaskedPhone = _authPhoneController.unmasked;
      if (_authPhoneController.fieldState == FieldStateType.error) {
        _authPhoneController.updateFieldState(FieldStateType.none, '');
      }
      if (unmaskedPhone.length == 10) submit();
    }
  }

  void _onRegPhoneChanged() {
    if (_isLoginModeEntity.value.data ?? true) return;
    if (!(_isCodeSentEntity.value.data ?? false)) {
      final unmaskedPhone = _regPhoneController.unmasked;
      if (_regPhoneController.fieldState == FieldStateType.error) {
        _regPhoneController.updateFieldState(FieldStateType.none, '');
      }
      // При регистрации мы ждем ввода телефона и логина
      // Не отправляем код автоматически, пока логин не введен?
      // Либо отправляем автоматически, если логин валиден
      if (unmaskedPhone.length == 10 &&
          _loginController.text.isNotEmpty &&
          _loginController.fieldState != FieldStateType.error) {
        submit();
      }
    }
  }

  void _onRegLoginChanged() {
    if (_isLoginModeEntity.value.data ?? true) return;
    if (!(_isCodeSentEntity.value.data ?? false)) {
      final login = _loginController.text;
      if (_loginController.fieldState == FieldStateType.error) {
        _loginController.updateFieldState(FieldStateType.none, '');
      }

      if (_regPhoneController.unmasked.length == 10 &&
          login.length >= 3 &&
          _loginController.fieldState != FieldStateType.error) {
        submit();
      }
    }
  }

  void _onAuthCodeChanged() {
    if (!(_isLoginModeEntity.value.data ?? true)) return;
    if (_isCodeSentEntity.value.data ?? false) {
      final unmaskedCode = _authCodeController.unmasked;
      if (_authCodeController.fieldState == FieldStateType.error) {
        _authCodeController.updateFieldState(FieldStateType.none, '');
      }
      if (unmaskedCode.length == 6) submit();
    }
  }

  void _onRegCodeChanged() {
    if (_isLoginModeEntity.value.data ?? true) return;
    if (_isCodeSentEntity.value.data ?? false) {
      final unmaskedCode = _regCodeController.unmasked;
      if (_regCodeController.fieldState == FieldStateType.error) {
        _regCodeController.updateFieldState(FieldStateType.none, '');
      }
      if (unmaskedCode.length == 6) submit();
    }
  }

  @override
  Future<void> submit() async {
    if (_isLoadingEntity.value.data ?? false) return;

    final isLoginMode = _isLoginModeEntity.value.data ?? true;
    final isCodeSent = _isCodeSentEntity.value.data ?? false;

    if (!await _validateFields(isLoginMode, isCodeSent)) return;

    _isLoadingEntity.content(true);

    try {
      if (isLoginMode) {
        await _handleLogin(isCodeSent);
      } else {
        await _handleRegistration(isCodeSent);
      }
    } catch (e) {
      _handleSubmitError(e, isLoginMode, isCodeSent);
    } finally {
      _isLoadingEntity.content(false);
    }
  }

  Future<bool> _validateFields(bool isLoginMode, bool isCodeSent) async {
    if (isLoginMode) {
      if (!isCodeSent) {
        final res = await _validatePhone(_authPhoneController.text);
        if (res.state == FieldStateType.error) return false;
      } else {
        final res = await _validateCode(_authCodeController.text);
        if (res.state == FieldStateType.error) return false;
      }
    } else {
      if (!isCodeSent) {
        final resPhone = await _validatePhone(_regPhoneController.text);
        final resLogin = await _validateLogin(_loginController.text);
        if (resPhone.state == FieldStateType.error) {
          _regPhoneController.updateFieldState(FieldStateType.error, resPhone.message);
          return false;
        }
        if (resLogin.state == FieldStateType.error || _loginController.text.isEmpty) {
          _loginController.updateFieldState(FieldStateType.error, resLogin.message ?? 'Введите логин');
          return false;
        }
      } else {
        final res = await _validateCode(_regCodeController.text);
        if (res.state == FieldStateType.error) return false;
      }
    }
    return true;
  }

  Future<void> _handleLogin(bool isCodeSent) async {
    if (!isCodeSent) {
      await _sendLoginSmsCode();
    } else {
      await _verifyLoginCode();
    }
  }

  Future<void> _sendLoginSmsCode() async {
    final phone = _authPhoneController.unmasked;

    try {
      final isUnique = await _authRepository.checkPhoneUnique(phone);
      if (isUnique) {
        _authPhoneController.updateFieldState(FieldStateType.error, 'Пользователь не найден, зарегистрируйтесь');
        return;
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return;
    }

    try {
      await _smsRepository.sendSmsCode(phone: phone);
      _isCodeSentEntity.content(true);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Future<void> _verifyLoginCode() async {
    final phone = _authPhoneController.unmasked;
    final code = _authCodeController.unmasked;

    try {
      await _authRepository.login(phone: phone, code: code);
      // TODO: Навигация после успешной авторизации
    } on DioException catch (e) {
      _handleDioError(e);
      _authCodeController.updateFieldState(FieldStateType.error, 'Неверный код');
    }
  }

  Future<void> _handleRegistration(bool isCodeSent) async {
    if (!isCodeSent) {
      await _sendRegistrationSmsCode();
    } else {
      await _verifyRegistrationCode();
    }
  }

  Future<void> _sendRegistrationSmsCode() async {
    final phone = _regPhoneController.unmasked;
    final login = _loginController.text;

    try {
      final isLoginUnique = await _authRepository.checkLoginUnique(login);
      if (!isLoginUnique) {
        _loginController.updateFieldState(FieldStateType.error, 'Логин уже занят');
        return;
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return;
    }

    try {
      final isUnique = await _authRepository.checkPhoneUnique(phone);
      if (!isUnique) {
        _regPhoneController.updateFieldState(FieldStateType.error, 'Пользователь уже существует, авторизуйтесь');
        return;
      }
    } on DioException catch (e) {
      _handleDioError(e);
      return;
    }

    try {
      await _smsRepository.sendSmsCode(phone: phone);
      _isCodeSentEntity.content(true);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Future<void> _verifyRegistrationCode() async {
    final phone = _regPhoneController.unmasked;
    final login = _loginController.text;
    final code = _regCodeController.unmasked;

    try {
      await _authRepository.register(login: login, phone: phone, code: code);
      // TODO: Навигация после успешной регистрации
    } on DioException catch (e) {
      _handleDioError(e);
      _regCodeController.updateFieldState(FieldStateType.error, 'Неверный код');
    }
  }

  void _handleDioError(DioException e) {
    if (e.response?.statusCode == 500) {
      _errorEntity.content('Непредвиденная ошибка сервера');
    } else if (e.response?.statusCode == 400) {
      _errorEntity.content('Некорректные данные');
    } else if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
      _errorEntity.content('Ошибка соединения, проверьте интернет');
    } else {
      _errorEntity.content('Произошла ошибка: ${e.message}');
    }
  }

  void _handleSubmitError(Object e, bool isLoginMode, bool isCodeSent) {
    final errorMessage = e.toString();
    if (isLoginMode) {
      if (!isCodeSent) {
        _authPhoneController.updateFieldState(FieldStateType.error, errorMessage);
      } else {
        _authCodeController.updateFieldState(FieldStateType.error, errorMessage);
      }
    } else {
      if (!isCodeSent) {
        _regPhoneController.updateFieldState(FieldStateType.error, errorMessage);
      } else {
        _regCodeController.updateFieldState(FieldStateType.error, errorMessage);
      }
    }
  }
}
