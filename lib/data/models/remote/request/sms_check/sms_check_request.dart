/// Модель данных для проверки СМС кода
class SmsCheckRequest {
  /// СМС код
  final String code;

  /// Создает модель запроса проверки СМС кода
  SmsCheckRequest({required this.code});

  /// Преобразует модель в JSON формат для отправки на сервер
  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }
}
