/// Перечисление доступных окружений (flavors) приложения
enum Flavor {
  /// Продуктовая (боевая) среда
  prod,

  /// Тестовая среда (для QA и тестирования перед релизом)
  stage,

  /// Среда разработки (для локальной разработки)
  dev;

  /// Получение базового URL API в зависимости от текущего окружения
  String get apiUrl {
    switch (this) {
      case Flavor.prod:
        return 'https://prod.api.com';
      case Flavor.stage:
        return 'https://stage.api.com';
      case Flavor.dev:
        return 'https://dev.api.com';
    }
  }
}

/// Класс для конфигурации окружения (синглтон)
/// Инициализируется один раз при старте приложения (в лаунчерах)
final class FlavorConfig {
  /// Инициализирует конфигурацию приложения
  /// [Flavor flavor] - тип окружения для запуска
  /// Выбрасывает [Exception], если конфигурация уже была инициализирована
  FlavorConfig({required this.flavor}) {
    // Проверка на то, что конфигурация инициализируется только один раз
    if (_data != null) throw Exception();
    _initWith(flavor);
  }

  /// Текущее окружение
  Flavor flavor;

  /// Внутреннее хранилище данных конфигурации
  static FlavorsData? _data;

  /// Внутренний метод инициализации данных
  void _initWith(Flavor flavor) {
    _data = FlavorsData(flavor: flavor);
  }

  /// Получение текущих данных конфигурации
  /// Выбрасывает [Exception], если доступ к данным происходит до инициализации
  static FlavorsData get data => _data ??= throw Exception();

  /// Быстрый доступ к URL API текущего окружения
  static String get apiUrl => data.apiUrl;

  /// Быстрый доступ к названию приложения для текущего окружения
  static String get appName => data.appName;
}

/// Класс-контейнер для хранения данных, специфичных для окружения
class FlavorsData {
  /// Создает контейнер данных для заданного окружения
  FlavorsData({required this.flavor});

  /// Текущее окружение
  final Flavor flavor;

  /// Возвращает URL API для текущего окружения
  String get apiUrl => flavor.apiUrl;

  /// Возвращает название приложения для текущего окружения
  String get appName => flavor.name;
}
