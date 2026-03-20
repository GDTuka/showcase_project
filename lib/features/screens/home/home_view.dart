import 'package:evvm/evvm.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/screens/home/home_vm.dart';

class HomeView extends WidgetView<IHomeVM> {
  const HomeView({super.key}) : super(homeVMF);

  @override
  Widget build(IHomeVM vm, BuildContext context) {
    return Scaffold(body: Center(child: Text('home')));
  }
}
