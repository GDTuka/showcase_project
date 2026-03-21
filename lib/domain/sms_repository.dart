import 'package:showcase_project/data/api/api/sms_api.dart';
import 'package:showcase_project/data/models/remote/models.dart';

/// Интерфейс репозитория для работы с СМС
abstract interface class ISmsRepository {
  /// Отправляет СМС код текущему пользователю
  Future<void> sendSmsCode({required String phone});

  /// Проверяет СМС код
  Future<bool> checkSmsCode({required String code});
}

/// Репозиторий для работы с СМС
/// Скрывает детали реализации API от UI слоя
class SmsRepository implements ISmsRepository {
  /// Инициализирует репозиторий с зависимостью от [ISmsApi]
  /// [ISmsApi smsApi] - API клиент для выполнения запросов
  SmsRepository({required ISmsApi smsApi}) : _smsApi = smsApi;

  final ISmsApi _smsApi;

  @override
  Future<void> sendSmsCode({required String phone}) async {
    return _smsApi.sendSmsCode(SendSmsCodeRequest(phone: phone));
  }

  @override
  Future<bool> checkSmsCode({required String code}) async {
    final request = SmsCheckRequest(code: code);
    return _smsApi.checkSmsCode(request);
  }
}
