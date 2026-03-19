import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/utils/app_text_field/text_field.dart';
import 'package:showcase_project/features/utils/app_text_field/text_field_controller.dart';

class AuthScreenWidget extends StatelessWidget {
  const AuthScreenWidget({
    super.key,
    required this.phoneController,
    required this.isLoadingListenable,
    required this.onSubmit,
  });

  final AppTextController phoneController;
  final EntityValueListenable<bool> isLoadingListenable;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        AppTextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
        ),
        const Spacer(),
        EntityStateNotifierBuilder<bool>(
          listenableEntityState: isLoadingListenable,
          builder: (context, isLoading) {
            final loading = isLoading ?? false;
            return ElevatedButton(
              onPressed: loading ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: loading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Авторизоваться / Зарегистрироваться'),
            );
          },
        ),
      ],
    );
  }
}
