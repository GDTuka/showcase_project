import 'package:flutter/material.dart';
import 'package:showcase_project/features/theme/colors.dart';

/// Класс, содержащий текстовые стили приложения
/// Предоставляет набор типографики, адаптированный под текущую цветовую тему
class AppTextStyles {
  /// Конструктор для создания набора текстовых стилей
  AppTextStyles({
    required this.headline1,
    required this.headline2,
    required this.headline3,
    required this.headline4,
    required this.headline5,
    required this.headline6,
    required this.subtitle1,
    required this.subtitle2,
    required this.body1,
    required this.body2,
    required this.button,
    required this.caption,
    required this.overline,
    required this.label,
  });

  /// Стиль для самых крупных заголовков
  final TextStyle headline1;

  /// Стиль для крупных заголовков
  final TextStyle headline2;

  /// Стиль для средних заголовков
  final TextStyle headline3;

  /// Стиль для небольших заголовков
  final TextStyle headline4;

  /// Стиль для мелких заголовков
  final TextStyle headline5;

  /// Стиль для самых мелких заголовков
  final TextStyle headline6;

  /// Стиль для основных подзаголовков
  final TextStyle subtitle1;

  /// Стиль для второстепенных подзаголовков
  final TextStyle subtitle2;

  /// Основной стиль текста (для параграфов)
  final TextStyle body1;

  /// Вторичный стиль текста (для дополнительной информации)
  final TextStyle body2;

  /// Стиль текста для кнопок
  final TextStyle button;

  /// Стиль для подписей (например, под иконками или полями ввода)
  final TextStyle caption;

  /// Стиль для надстрочного текста
  final TextStyle overline;

  /// Стиль для лейблов (например, в формах)
  final TextStyle label;

  /// Фабричный метод для создания светлых текстовых стилей
  /// [AppColors colors] - цвета светлой темы, используемые для окрашивания текста
  factory AppTextStyles.light(AppColors colors) {
    return AppTextStyles(
      headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: colors.onBackground, letterSpacing: -0.5),
      headline2: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: colors.onBackground, letterSpacing: -0.25),
      headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: colors.onBackground),
      headline4: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: colors.onBackground, letterSpacing: 0.25),
      headline5: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: colors.onBackground),
      headline6: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colors.onBackground, letterSpacing: 0.15),
      subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: colors.onBackground, letterSpacing: 0.15),
      subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colors.onBackground, letterSpacing: 0.1),
      body1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: colors.onBackground, letterSpacing: 0.5),
      body2: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.onBackground, letterSpacing: 0.25),
      button: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colors.onPrimary, letterSpacing: 0.5),
      caption: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: colors.onBackground.withValues(alpha: 0.6),
        letterSpacing: 0.4,
      ),
      overline: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colors.onBackground.withValues(alpha: 0.8),
        letterSpacing: 1.5,
      ),
      label: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colors.onBackground, letterSpacing: 0.25),
    );
  }

  /// Фабричный метод для создания темных текстовых стилей
  /// [AppColors colors] - цвета темной темы, используемые для окрашивания текста
  factory AppTextStyles.dark(AppColors colors) {
    return AppTextStyles(
      headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: colors.onBackground, letterSpacing: -0.5),
      headline2: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: colors.onBackground, letterSpacing: -0.25),
      headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: colors.onBackground),
      headline4: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: colors.onBackground, letterSpacing: 0.25),
      headline5: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: colors.onBackground),
      headline6: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colors.onBackground, letterSpacing: 0.15),
      subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: colors.onBackground, letterSpacing: 0.15),
      subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colors.onBackground, letterSpacing: 0.1),
      body1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: colors.onBackground, letterSpacing: 0.5),
      body2: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.onBackground, letterSpacing: 0.25),
      button: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: colors.onPrimary, letterSpacing: 0.5),
      caption: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: colors.onBackground.withValues(alpha: 0.6),
        letterSpacing: 0.4,
      ),
      overline: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colors.onBackground.withValues(alpha: 0.8),
        letterSpacing: 1.5,
      ),
      label: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colors.onBackground, letterSpacing: 0.25),
    );
  }
}

/// Класс управления темой приложения
/// Наследуется от [ChangeNotifier] для оповещения виджетов при смене темы
class AppTheme extends ChangeNotifier {
  /// Внутренний инстанс синглтона
  static final AppTheme _instance = AppTheme._internal();

  /// Фабрика, возвращающая всегда один и тот же инстанс (синглтон)
  factory AppTheme() => _instance;

  /// Приватный конструктор
  AppTheme._internal();

  /// Текущий режим темы (светлая/темная)
  ThemeMode _themeMode = ThemeMode.dark;

  /// Геттер текущего режима темы
  ThemeMode get themeMode => _themeMode;

  /// Переключает тему между светлой и темной
  /// Вызывает перерисовку всех слушателей (всего приложения)
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  /// Устанавливает конкретный режим темы
  /// [ThemeMode mode] - новый режим
  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  /// Возвращает набор цветов в зависимости от текущей темы контекста
  /// [BuildContext context] - контекст для определения яркости темы
  static AppColors getColors(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? AppColors.dark() : AppColors.light();
  }

  /// Возвращает набор текстовых стилей в зависимости от текущей темы контекста
  /// [BuildContext context] - контекст для определения яркости темы
  static AppTextStyles getTextStyles(BuildContext context) {
    final colors = getColors(context);
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? AppTextStyles.dark(colors) : AppTextStyles.light(colors);
  }

  /// Конфигурация светлой темы Flutter (Material)
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.light().primary, brightness: Brightness.light),
    scaffoldBackgroundColor: AppColors.light().background,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.light(AppColors.light()).headline1,
      displayMedium: AppTextStyles.light(AppColors.light()).headline2,
      displaySmall: AppTextStyles.light(AppColors.light()).headline3,
      headlineMedium: AppTextStyles.light(AppColors.light()).headline4,
      headlineSmall: AppTextStyles.light(AppColors.light()).headline5,
      titleLarge: AppTextStyles.light(AppColors.light()).headline6,
      titleMedium: AppTextStyles.light(AppColors.light()).subtitle1,
      titleSmall: AppTextStyles.light(AppColors.light()).subtitle2,
      bodyLarge: AppTextStyles.light(AppColors.light()).body1,
      bodyMedium: AppTextStyles.light(AppColors.light()).body2,
      labelLarge: AppTextStyles.light(AppColors.light()).button,
      bodySmall: AppTextStyles.light(AppColors.light()).caption,
      labelSmall: AppTextStyles.light(AppColors.light()).overline,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.light().surface,
      foregroundColor: AppColors.light().onSurface,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.light().primary,
        foregroundColor: AppColors.light().onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.light().primary,
        side: BorderSide(color: AppColors.light().border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.light().primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.light().surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.light().border, width: 1),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.light().surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.light().border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.light().border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.light().focus, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.light().error),
      ),
    ),
  );

  /// Конфигурация темной темы Flutter (Material)
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.dark().primary, brightness: Brightness.dark),
    scaffoldBackgroundColor: AppColors.dark().background,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.dark(AppColors.dark()).headline1,
      displayMedium: AppTextStyles.dark(AppColors.dark()).headline2,
      displaySmall: AppTextStyles.dark(AppColors.dark()).headline3,
      headlineMedium: AppTextStyles.dark(AppColors.dark()).headline4,
      headlineSmall: AppTextStyles.dark(AppColors.dark()).headline5,
      titleLarge: AppTextStyles.dark(AppColors.dark()).headline6,
      titleMedium: AppTextStyles.dark(AppColors.dark()).subtitle1,
      titleSmall: AppTextStyles.dark(AppColors.dark()).subtitle2,
      bodyLarge: AppTextStyles.dark(AppColors.dark()).body1,
      bodyMedium: AppTextStyles.dark(AppColors.dark()).body2,
      labelLarge: AppTextStyles.dark(AppColors.dark()).button,
      bodySmall: AppTextStyles.dark(AppColors.dark()).caption,
      labelSmall: AppTextStyles.dark(AppColors.dark()).overline,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.dark().surface,
      foregroundColor: AppColors.dark().onSurface,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.dark().primary,
        foregroundColor: AppColors.dark().onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.dark().primary,
        side: BorderSide(color: AppColors.dark().border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.dark().primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.dark().surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.dark().border, width: 1),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.dark().surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.dark().border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.dark().border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.dark().focus, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.dark().error),
      ),
    ),
  );
}

/// Расширение для быстрого доступа к теме из контекста
extension AppThemeExtension on BuildContext {
  /// Возвращает цвета текущей темы
  AppColors get colors => AppTheme.getColors(this);

  /// Возвращает инстанс менеджера темы
  AppTheme get theme => AppTheme();

  /// Возвращает текстовые стили текущей темы
  AppTextStyles get textStyles => AppTheme.getTextStyles(this);
}
