import 'package:flutter/material.dart';
import 'package:showcase_project/features/theme/colors.dart';

class AppTheme extends ChangeNotifier {
  static final AppTheme _instance = AppTheme._internal();
  factory AppTheme() => _instance;
  AppTheme._internal();

  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  static AppColors getColors(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? AppColors.dark() : AppColors.light();
  }

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.light().primary, brightness: Brightness.light),
    scaffoldBackgroundColor: AppColors.light().background,
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

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.dark().primary, brightness: Brightness.dark),
    scaffoldBackgroundColor: AppColors.dark().background,
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

extension AppThemeExtension on BuildContext {
  AppColors get colors => AppTheme.getColors(this);
  AppTheme get theme => AppTheme();
}
