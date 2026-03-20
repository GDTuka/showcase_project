/// Модель запроса для авторизации пользователя
class LoginRequest {
  /// Номер телефона пользователя
  final String phone;

  /// Код из СМС
  final String code;

  /// Создает модель запроса авторизации
  /// [String phone] - номер телефона
  /// [String code] - код из СМС
  LoginRequest({required this.phone, required this.code});

  /// Преобразует модель в JSON формат для отправки на сервер
  Map<String, dynamic> toJson() {
    return {'phone': phone, 'code': code};
  }
}
