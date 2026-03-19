/// Модель запроса для регистрации нового пользователя
class RegisterRequest {
  /// Желаемый логин пользователя
  final String login;
  
  /// Номер телефона пользователя
  final String phone;
  
  /// Пароль пользователя в открытом виде
  final String password;

  /// Создает модель запроса регистрации
  /// [String login] - логин
  /// [String phone] - телефон
  /// [String password] - пароль
  RegisterRequest({
    required this.login,
    required this.phone,
    required this.password,
  });

  /// Преобразует модель в JSON формат для отправки на сервер
  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'phone': phone,
      'password': password,
    };
  }
}
