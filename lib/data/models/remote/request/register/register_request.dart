/// Модель запроса для регистрации нового пользователя
class RegisterRequest {
  /// Желаемый логин пользователя
  final String login;

  /// Номер телефона пользователя
  final String phone;

  /// Код из СМС
  final String code;

  /// Создает модель запроса регистрации
  /// [String login] - логин
  /// [String phone] - телефон
  /// [String code] - код из СМС
  RegisterRequest({required this.login, required this.phone, required this.code});

  /// Преобразует модель в JSON формат для отправки на сервер
  Map<String, dynamic> toJson() {
    return {'login': login, 'phone': phone, 'code': code};
  }
}
