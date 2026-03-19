/// Модель данных пользователя, получаемая от сервера
class UserDto {
  /// Уникальный идентификатор пользователя
  final int id;
  
  /// Логин пользователя в системе
  final String login;
  
  /// Номер телефона пользователя
  final String phone;
  
  /// Дата и время создания аккаунта в формате ISO 8601
  final String createdAt;

  /// Создает экземпляр модели пользователя
  /// [int id] - идентификатор
  /// [String login] - логин
  /// [String phone] - телефон
  /// [String createdAt] - дата создания
  UserDto({
    required this.id,
    required this.login,
    required this.phone,
    required this.createdAt,
  });

  /// Фабричный метод для создания [UserDto] из JSON
  /// [Map<String, dynamic> json] - данные от сервера
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int,
      login: json['login'] as String,
      phone: json['phone'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  /// Преобразует модель в JSON формат
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'phone': phone,
      'created_at': createdAt,
    };
  }
}
