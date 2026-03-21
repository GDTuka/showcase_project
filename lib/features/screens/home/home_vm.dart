import 'package:collection/collection.dart';
import 'package:evvm/evvm.dart';
import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';
import 'package:showcase_project/features/navigation/router.dart';
import 'package:showcase_project/features/screens/home/home_view.dart';

abstract interface class IHomeVM implements IViewModel {
  EntityValueListenable<Routes> get currentScreenListenable;
}

HomeVM homeVMF(BuildContext context) {
  return HomeVM();
}

class HomeVM extends ViewModel<HomeView> implements IHomeVM {
  /// router state observer
  /// listens for route argument changes to update UI
  late final OctopusStateObserver _observer;

  final _currentScreenEntity = EntityStateNotifier<Routes>.value(Routes.home);

  @override
  EntityValueListenable<Routes> get currentScreenListenable => _currentScreenEntity;

  void _onObserverChange() {
    final pageName = _observer.value.arguments['activePage'] ?? '';

    final value = Routes.values.firstWhereOrNull((e) => e.name == pageName);

    if (value != null) {
      _currentScreenEntity.content(value);
    }
  }

  @override
  void init() {
    _observer = context.octopus.observer;
    _observer.addListener(_onObserverChange);
    super.init();
  }
}
