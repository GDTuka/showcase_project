import 'package:evvm/evvm.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/screens/home/home_view.dart';

abstract interface class IHomeVM implements IViewModel {}

HomeVM homeVMF(BuildContext context) {
  return HomeVM();
}

class HomeVM extends ViewModel<HomeView> implements IHomeVM {}
