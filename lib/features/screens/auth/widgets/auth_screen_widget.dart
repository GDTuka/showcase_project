import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/screens/auth/auth_vm.dart';
import 'package:showcase_project/features/utils/app_text_field/text_field.dart';

class AuthScreenWidget extends StatelessWidget {
  final IAuthVm vm;

  const AuthScreenWidget({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        AppTextField(controller: vm.phoneController, keyboardType: TextInputType.phone),
        const Spacer(),
        EntityStateNotifierBuilder<bool>(
          listenableEntityState: vm.isLoadingListenable,
          builder: (context, isLoading) {
            final loading = isLoading ?? false;
            return ElevatedButton(
              onPressed: loading ? null : vm.submit,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: loading
                  ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Авторизоваться / Зарегистрироваться'),
            );
          },
        ),
      ],
    );
  }
}
