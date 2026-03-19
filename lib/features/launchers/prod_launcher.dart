import 'package:showcase_project/features/utils/flavor.dart';
import 'package:showcase_project/runner.dart';

Future<void> main(List<String> args) async {
  runner(FlavorConfig(flavor: Flavor.prod));
}
