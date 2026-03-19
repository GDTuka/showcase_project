import 'package:showcase_project/features/utils/flavor.dart';
import 'package:showcase_project/runner.dart';

/// Точка входа для запуска приложения в среде разработки (Development)
/// Настраивает конфигурацию для dev-окружения и вызывает общий раннер
/// [List<String> args] - аргументы командной строки
Future<void> main(List<String> args) async {
  // Запуск основного потока приложения с конфигурацией dev
  runner(FlavorConfig(flavor: Flavor.dev));
}
