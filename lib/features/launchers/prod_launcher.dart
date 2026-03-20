import 'package:showcase_project/features/utils/flavor.dart';
import 'package:showcase_project/runner.dart';

/// Точка входа для запуска приложения в боевой среде (Production)
/// Настраивает конфигурацию для prod-окружения и вызывает общий раннер
Future<void> main() async {
  // Запуск основного потока приложения с конфигурацией prod
  runner(FlavorConfig(flavor: Flavor.prod));
}
