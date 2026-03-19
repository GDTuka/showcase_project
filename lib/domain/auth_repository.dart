import 'dart:convert';

import 'package:showcase_project/data/api/api/auth_api.dart';
import 'package:showcase_project/data/models/remote/dto/user/user_dto.dart';
import 'package:showcase_project/data/models/remote/request/login/login_request.dart';
import 'package:showcase_project/data/models/remote/request/register/register_request.dart';
import 'package:showcase_project/data/storage/jwt_storage.dart';
import 'package:showcase_project/data/storage/refersh_token_storage.dart';

/// Интерфейс репозитория для работы с авторизацией
abstract interface class IAuthRepository {
  /// Регистрирует нового пользователя
  Future<int> register({required String login, required String phone, required String password});

  /// Авторизует существующего пользователя
  Future<UserDto> login({required String login, required String password});

  /// Проверяет уникальность номера телефона
  Future<bool> checkPhoneUnique(String phone);

  /// Проверяет уникальность логина
  Future<bool> checkLoginUnique(String login);
}

/// Репозиторий для работы с авторизацией
/// Скрывает детали реализации API от UI слоя
class AuthRepository implements IAuthRepository {
  /// Инициализирует репозиторий с зависимостью от [AuthApi]
  /// [AuthApi authApi] - API клиент для выполнения запросов
  AuthRepository({
    required IAuthApi authApi,
    required JWTStorage jwtStorage,
    required RefreshTokenStorage refreshTokenStorage,
  }) : _authApi = authApi,
       _jwtStorage = jwtStorage,
       _refreshTokenStorage = refreshTokenStorage;

  final IAuthApi _authApi;
  final JWTStorage _jwtStorage;
  final RefreshTokenStorage _refreshTokenStorage;

  @override
  Future<int> register({required String login, required String phone, required String password}) async {
    final res = await _authApi.register(RegisterRequest(login: login, phone: phone, password: password));

    final jwt = res.headers.value('X-Access-Token');
    final refresh = res.headers.value('X-Refresh-Token');

    if (jwt == null || refresh == null) {
      throw Exception('Missing authentication tokens');
    }

    await _jwtStorage.writeToken(jwt);
    await _refreshTokenStorage.writeToken(refresh);

    return res.data?.id ?? 0;
  }

  @override
  Future<UserDto> login({required String login, required String password}) async {
    final res = await _authApi.login(LoginRequest(login: login, password: password));

    final jwt = res.headers.value('X-Access-Token');
    final refresh = res.headers.value('X-Refresh-Token');

    if (jwt == null || refresh == null) {
      throw Exception('Missing authentication tokens');
    }

    await _jwtStorage.writeToken(jwt);
    await _refreshTokenStorage.writeToken(refresh);

    return UserDto.fromJson(jsonDecode(res.data));
  }

  @override
  Future<bool> checkPhoneUnique(String phone) async {
    return _authApi.checkPhoneUnique(phone);
  }

  @override
  Future<bool> checkLoginUnique(String login) async {
    return _authApi.checkLoginUnique(login);
  }
}
