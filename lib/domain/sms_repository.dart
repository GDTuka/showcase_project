import 'package:showcase_project/data/api/api/user_api.dart';
import 'package:showcase_project/data/models/remote/request/sms_check/sms_check_request.dart';

/// Интерфейс репозитория для работы с СМС
abstract interface class ISmsRepository {
  /// Отправляет СМС код текущему пользователю
  Future<void> sendSmsCode({required String phone});

  /// Проверяет СМС код
  Future<void> checkSmsCode({required String code});
}

/// Репозиторий для работы с СМС
/// Скрывает детали реализации API от UI слоя
class SmsRepository implements ISmsRepository {
  /// Инициализирует репозиторий с зависимостью от [UserApi]
  /// [UserApi userApi] - API клиент для выполнения запросов
  SmsRepository({required UserApi userApi}) : _userApi = userApi;

  final UserApi _userApi;

  @override
  Future<void> sendSmsCode({required String phone}) async {
    return _userApi.sendSmsCode(phone: phone);
  }

  @override
  Future<bool> checkSmsCode({required String code}) async {
    final request = SmsCheckRequest(code: code);
    return _userApi.checkSmsCode(request);
  }
}
