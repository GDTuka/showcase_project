import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';
import 'package:padi/padi.dart';
import 'package:showcase_project/features/navigation/router.dart';

class GlobalScope extends Padi {
  late Octopus router;

  @override
  Future<void> initAsync(BuildContext context) async {
    router = Octopus(routes: Routes.values);
  }
}

extension GlobalScopeExtension on BuildContext {
  GlobalScope get global => PadiScope.of<GlobalScope>(this);
}
