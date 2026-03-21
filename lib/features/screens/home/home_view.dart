import 'package:evvm/evvm.dart';
import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/navigation/router.dart';
import 'package:showcase_project/features/screens/add_habbit/add_habbit_view.dart';
import 'package:showcase_project/features/screens/home/home_vm.dart';
import 'package:showcase_project/features/screens/home/widgets/home_screen.dart';

class HomeView extends WidgetView<IHomeVM> {
  const HomeView({super.key}) : super(homeVMF);

  @override
  Widget build(IHomeVM vm, BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: EntityStateNotifierBuilder(
              listenableEntityState: vm.currentScreenListenable,
              builder: (context, data) {
                return switch (data) {
                  Routes.addHabbit => const AddHabbitView(),
                  Routes.home => const HomeScreen(),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
