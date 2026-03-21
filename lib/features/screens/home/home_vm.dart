import 'package:evvm/evvm.dart';
import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/navigation/router.dart';
import 'package:showcase_project/features/screens/home/home_view.dart';

abstract interface class IHomeVM implements IViewModel {
  EntityValueListenable<Routes> get currentScreenListenable;

  void onNavBarTap(Routes route);
}

HomeVM homeVMF(BuildContext context) {
  return HomeVM();
}

class HomeVM extends ViewModel<HomeView> implements IHomeVM {
  final _currentScreen = EntityStateNotifier<Routes>.value(Routes.home);

  @override
  EntityValueListenable<Routes> get currentScreenListenable => _currentScreen;

  @override
  void init() {
    super.init();
  }

  @override
  void onNavBarTap(Routes route) {
    _currentScreen.content(route);
  }
}
