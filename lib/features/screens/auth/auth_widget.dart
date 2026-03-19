import 'package:evvm/evvm.dart';
import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/screens/auth/auth_vm.dart';
import 'package:showcase_project/features/screens/auth/widgets/auth_screen_widget.dart';
import 'package:showcase_project/features/screens/auth/widgets/register_screen_widget.dart';

class AuthWidget extends WidgetView<IAuthVm> {
  const AuthWidget({super.key}) : super(authVMF);

  @override
  Widget build(IAuthVm vm, BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация / Регистрация')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: EntityStateNotifierBuilder<bool>(
            listenableEntityState: vm.isCodeSentListenable,
            builder: (context, isCodeSent) {
              if (isCodeSent ?? false) {
                return RegisterScreenWidget(vm: vm);
              }
              return AuthScreenWidget(vm: vm);
            },
          ),
        ),
      ),
    );
  }
}
