/// Модель запроса для проверки уникальности поля
class CheckUniqueRequest {
  /// Значение, которое нужно проверить (например, логин или номер телефона)
  final String value;

  /// Создает модель запроса для проверки уникальности
  /// [String value] - проверяемое значение
  CheckUniqueRequest({
    required this.value,
  });

  /// Преобразует модель в JSON формат для отправки на сервер
  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}
