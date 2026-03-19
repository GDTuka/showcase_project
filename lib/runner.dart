import 'dart:async';

import 'package:flutter/material.dart';
import 'package:padi/padi.dart';
import 'package:showcase_project/app/app.dart';
import 'package:showcase_project/di/scopes/global_scope.dart';
import 'package:showcase_project/features/utils/flavor.dart';
import 'package:showcase_project/features/widgets/scopes_widgets/scope_error_widget.dart';
import 'package:showcase_project/features/widgets/scopes_widgets/scope_loader_widget.dart';

void runner(FlavorConfig cfg) {
  runZonedGuarded(
    () {
      runApp(
        PadiWidget(
          create: GlobalScope.new,
          loaderBuilder: (context) => ScopeLoaderWidget(),
          errorBuilder: (context) => ScopeErrorWidget(),
          child: App(),
        ),
      );
    },
    (error, stack) {
      // Error handling
    },
  );
}
