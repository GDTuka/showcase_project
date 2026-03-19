import 'package:showcase_project/features/utils/flavor.dart';
import 'package:showcase_project/runner.dart';

/// Точка входа для запуска приложения в тестовой среде (Stage)
/// Настраивает конфигурацию для stage-окружения и вызывает общий раннер
/// [List<String> args] - аргументы командной строки
Future<void> main(List<String> args) async {
  // Запуск основного потока приложения с конфигурацией stage
  runner(FlavorConfig(flavor: Flavor.stage));
}
