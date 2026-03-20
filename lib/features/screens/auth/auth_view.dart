import 'package:evvm/evvm.dart';
import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/screens/auth/auth_vm.dart';
import 'package:showcase_project/features/screens/auth/widgets/auth_screen_widget.dart';
import 'package:showcase_project/features/screens/auth/widgets/register_screen_widget.dart';

class AuthView extends WidgetView<IAuthVm> {
  const AuthView({super.key}) : super(authVMF);

  @override
  Widget build(IAuthVm vm, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: EntityStateNotifierBuilder(
          listenableEntityState: vm.isLoginModeListenable,
          builder: (context, data) {
            return Text(data ?? false ? 'Авторизация' : 'Регистрация');
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: EntityStateNotifierBuilder<bool>(
            listenableEntityState: vm.isLoginModeListenable,
            builder: (context, isLoginMode) {
              if (isLoginMode ?? false) {
                return AuthScreenWidget(
                  authPhoneController: vm.authPhoneController,
                  loginController: vm.loginController,
                  isLoadingListenable: vm.isLoadingListenable,
                  isLoginModeListenable: vm.isLoginModeListenable,
                  errorListenable: vm.errorListenable,
                  sendCodeButtonEnable: vm.sendCodeButtonEnableListenable,
                  onSubmit: vm.submit,
                  onToggleMode: vm.toggleMode,
                );
              }
              return RegisterScreenWidget(
                regPhoneController: vm.regPhoneController,

                regCodeController: vm.regCodeController,
                loginController: vm.loginController,
                codeSentListenable: vm.isCodeSentListenable,
                isLoadingListenable: vm.isLoadingListenable,
                errorListenable: vm.errorListenable,
                sendCodeButtonEnableListenable: vm.sendCodeButtonEnableListenable,
                onSubmit: vm.submit,
                onToggleMode: vm.toggleMode,
              );
            },
          ),
        ),
      ),
    );
  }
}
