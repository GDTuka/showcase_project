import 'package:flutter/material.dart';

class AppColors {
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

  final Color primary;
  final Color secondary;
  final Color onPrimary;
  final Color onSecondary;
  final Color focus;
  final Color onFocus;
  final Color pressed;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color error;
  final Color onError;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color info;
  final Color onInfo;
  final Color border;
  final Color divider;
  final Color shadow;
  final Color scrim;

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

  // Convenience getters for common colors
  Color get cardBackground => surface;
  Color get cardBorder => border;
  Color get textPrimary => onBackground;
  Color get textSecondary => onSurface.withValues(alpha: 0.7);
  Color get textTertiary => onSurface.withValues(alpha: 0.5);
  Color get iconPrimary => onSurface;
  Color get iconSecondary => onSurface.withValues(alpha: 0.6);
  Color get buttonDisabled => onSurface.withValues(alpha: 0.3);
  Color get overlay => scrim;
}
