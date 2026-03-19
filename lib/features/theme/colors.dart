import 'package:flutter/material.dart';

/// Класс, содержащий цветовую палитру приложения
/// Предоставляет набор базовых и семантических цветов для использования в UI
class AppColors {
  /// Конструктор для создания цветовой палитры
  /// Требует указания всех основных цветов, используемых в приложении
  AppColors({
    required this.primary,
    required this.secondary,
    required this.onPrimary,
    required this.onSecondary,
    required this.focus,
    required this.onFocus,
    required this.pressed,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.error,
    required this.onError,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
    required this.border,
    required this.divider,
    required this.shadow,
    required this.scrim,
  });

  /// Основной цвет (например, для главных кнопок и акцентов)
  final Color primary;

  /// Вторичный цвет
  final Color secondary;

  /// Цвет текста/иконок на фоне primary
  final Color onPrimary;

  /// Цвет текста/иконок на фоне secondary
  final Color onSecondary;

  /// Цвет состояния фокуса
  final Color focus;

  /// Цвет элементов на фоне focus
  final Color onFocus;

  /// Цвет состояния нажатия
  final Color pressed;

  /// Основной цвет фона экранов
  final Color background;

  /// Цвет текста/иконок на фоне background
  final Color onBackground;

  /// Цвет поверхностей (карточек, диалогов)
  final Color surface;

  /// Цвет текста/иконок на фоне surface
  final Color onSurface;

  /// Цвет для ошибок и критических действий
  final Color error;

  /// Цвет элементов на фоне error
  final Color onError;

  /// Цвет для успешных действий
  final Color success;

  /// Цвет элементов на фоне success
  final Color onSuccess;

  /// Цвет для предупреждений
  final Color warning;

  /// Цвет элементов на фоне warning
  final Color onWarning;

  /// Цвет для информационных сообщений
  final Color info;

  /// Цвет элементов на фоне info
  final Color onInfo;

  /// Цвет рамок и границ
  final Color border;

  /// Цвет разделителей
  final Color divider;

  /// Цвет теней
  final Color shadow;

  /// Цвет затемнения (под диалогами и модалками)
  final Color scrim;

  /// Фабричный метод для создания темной цветовой палитры
  factory AppColors.dark() {
    return AppColors(
      primary: const Color(0xFF3A6B97),
      secondary: const Color(0xFF5A8BB7),
      onPrimary: const Color(0xFFFFFFFF),
      onSecondary: const Color(0xFF051119),
      focus: const Color(0xFF4A7BA7),
      onFocus: const Color(0xFFFFFFFF),
      pressed: const Color(0xFF2A5B87),
      background: const Color(0xFF051119),
      onBackground: const Color(0xFFD8E8F8),
      surface: const Color(0xFF0A1929),
      onSurface: const Color(0xFFD8E8F8),
      error: const Color(0xFFFF6B6B),
      onError: const Color(0xFF051119),
      success: const Color(0xFF4ECDC4),
      onSuccess: const Color(0xFF051119),
      warning: const Color(0xFFFFD93D),
      onWarning: const Color(0xFF051119),
      info: const Color(0xFF3A6B97),
      onInfo: const Color(0xFFFFFFFF),
      border: const Color(0xFF1A2B3A),
      divider: const Color(0xFF0A1929),
      shadow: const Color(0x33000000),
      scrim: const Color(0xB3000000),
    );
  }

  /// Фабричный метод для создания светлой цветовой палитры
  factory AppColors.light() {
    return AppColors(
      primary: const Color(0xFF6C63FF),
      secondary: const Color(0xFF9B94FF),
      onPrimary: const Color(0xFFFFFFFF),
      onSecondary: const Color(0xFF1A1A2E),
      focus: const Color(0xFF5C53EF),
      onFocus: const Color(0xFFFFFFFF),
      pressed: const Color(0xFF4C43DF),
      background: const Color(0xFFFAFAFF),
      onBackground: const Color(0xFF1A1A2E),
      surface: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFF1A1A2E),
      error: const Color(0xFFE53E3E),
      onError: const Color(0xFFFFFFFF),
      success: const Color(0xFF38A169),
      onSuccess: const Color(0xFFFFFFFF),
      warning: const Color(0xFFD69E2E),
      onWarning: const Color(0xFFFFFFFF),
      info: const Color(0xFF3182CE),
      onInfo: const Color(0xFFFFFFFF),
      border: const Color(0xFFE2E8F0),
      divider: const Color(0xFFEDF2F7),
      shadow: const Color(0x1A000000),
      scrim: const Color(0x99000000),
    );
  }

  // Удобные геттеры для часто используемых семантических цветов

  /// Цвет фона для карточек
  Color get cardBackground => surface;

  /// Цвет рамки для карточек
  Color get cardBorder => border;

  /// Основной цвет текста
  Color get textPrimary => onBackground;

  /// Вторичный (приглушенный) цвет текста
  Color get textSecondary => onSurface.withValues(alpha: 0.7);

  /// Третичный (сильно приглушенный) цвет текста
  Color get textTertiary => onSurface.withValues(alpha: 0.5);

  /// Основной цвет иконок
  Color get iconPrimary => onSurface;

  /// Вторичный цвет иконок
  Color get iconSecondary => onSurface.withValues(alpha: 0.6);

  /// Цвет задизейбленной кнопки
  Color get buttonDisabled => onSurface.withValues(alpha: 0.3);

  /// Цвет оверлея (затемнения)
  Color get overlay => scrim;
}
