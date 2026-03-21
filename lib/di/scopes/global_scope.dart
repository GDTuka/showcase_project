import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:octopus/octopus.dart';
import 'package:padi/padi.dart';
import 'package:showcase_project/data/api/api/auth_api.dart';
import 'package:showcase_project/data/api/api/profile_api.dart';
import 'package:showcase_project/data/api/api/relation_api.dart';
import 'package:showcase_project/data/api/api/sms_api.dart';
import 'package:showcase_project/data/api/api/user_api.dart';
import 'package:showcase_project/data/api/interceptors/logger_interceptor.dart';
import 'package:showcase_project/data/storage/jwt_storage.dart';
import 'package:showcase_project/data/storage/refersh_token_storage.dart';
import 'package:showcase_project/domain/auth_repository.dart';
import 'package:showcase_project/domain/profile_repository.dart';
import 'package:showcase_project/domain/relation_repository.dart';
import 'package:showcase_project/domain/user_repository.dart';
import 'package:showcase_project/domain/sms_repository.dart';
import 'package:showcase_project/features/navigation/guards/auth_guard.dart';
import 'package:showcase_project/features/navigation/router.dart';
import 'package:showcase_project/features/utils/flavor.dart';

/// Глобальная область видимости для зависимостей приложения
/// Содержит все сервисы и контроллеры, которые должны жить на протяжении всего жизненного цикла приложения
/// Наследуется от [Padi] для интеграции с DI
class GlobalScope extends Padi {
  /// Роутер приложения для управления навигацией
  late final Octopus router;

  /// Клиент для сетевых запросов
  late final Dio dio;

  /// Репозиторий для работы с авторизацией
  late final IAuthRepository authRepository;

  /// Репозиторий для работы с пользователями
  late final IUserRepository userRepository;

  late final IProfileRepository profileRepository;

  late final IRelationRepository relationRepository;

  /// Репозиторий для работы с СМС
  late final ISmsRepository smsRepository;

  /// Secure storage для хранения конфиденциальных данных
  late final FlutterSecureStorage secureStorage;

  /// Хранилище JWT токена
  late final JWTStorage jwtStorage;

  /// Хранилище refresh токена
  late final RefreshTokenStorage refreshTokenStorage;

  /// Асинхронная инициализация глобальных зависимостей
  /// Вызывается при запуске приложения до показа основного экрана
  /// [BuildContext context] - контекст приложения
  @override
  Future<void> initAsync(BuildContext context) async {
    // Инициализация secure storage
    secureStorage = FlutterSecureStorage();
    jwtStorage = JWTStorage(storage: secureStorage);
    refreshTokenStorage = RefreshTokenStorage(storage: secureStorage);

    // Инициализация роутера со списком доступных маршрутов
    router = Octopus(
      routes: Routes.values,
      guards: [AuthGuard(jwtStorage: jwtStorage)],
      initialState: OctopusState(
        children: [
          OctopusNode(name: Routes.home.name, arguments: {"activePage": "home"}, children: []),
        ],
        arguments: {},
        intention: OctopusStateIntention.auto,
      ),
    );

    // Инициализация сетевого клиента
    dio = Dio(
      BaseOptions(
        baseUrl: FlavorConfig.apiUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    dio.interceptors.add(LoggerInterceptor());

    // Инициализация API
    final authApi = AuthApi(dio: dio);
    final userApi = UserApi(dio: dio);
    final smsApi = SmsApi(dio: dio);
    final profileApi = ProfileApi(dio: dio);
    final relationApi = RelationApi(dio: dio);

    // Инициализация репозиториев
    authRepository = AuthRepository(authApi: authApi, jwtStorage: jwtStorage, refreshTokenStorage: refreshTokenStorage);
    userRepository = UserRepository(userApi: userApi);
    profileRepository = ProfileRepository(profileApi: profileApi);
    relationRepository = RelationRepository(relationApi: relationApi);
    smsRepository = SmsRepository(smsApi: smsApi);
  }
}

/// Расширение для быстрого доступа к [GlobalScope] из [BuildContext]
extension GlobalScopeExtension on BuildContext {
  /// Возвращает экземпляр [GlobalScope], привязанный к текущему контексту
  GlobalScope get global => PadiScope.of<GlobalScope>(this);
}
