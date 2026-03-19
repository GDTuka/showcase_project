/// Модель запроса для авторизации пользователя
class LoginRequest {
  /// Логин пользователя
  final String login;
  
  /// Пароль пользователя в открытом виде
  final String password;

  /// Создает модель запроса авторизации
  /// [String login] - логин
  /// [String password] - пароль
  LoginRequest({
    required this.login,
    required this.password,
  });

  /// Преобразует модель в JSON формат для отправки на сервер
  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
    };
  }
}
