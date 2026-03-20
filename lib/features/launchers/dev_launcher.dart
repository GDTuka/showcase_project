import 'package:showcase_project/features/utils/flavor.dart';
import 'package:showcase_project/runner.dart';

/// Точка входа для запуска приложения в среде разработки (Development)
/// Настраивает конфигурацию для dev-окружения и вызывает общий раннер
Future<void> main() async {
  // Запуск основного потока приложения с конфигурацией dev
  runner(FlavorConfig(flavor: Flavor.dev));
}
