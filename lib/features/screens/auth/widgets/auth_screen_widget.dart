import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/theme/theme.dart';
import 'package:showcase_project/features/utils/app_text_field/text_field.dart';
import 'package:showcase_project/features/utils/app_text_field/text_field_controller.dart';
import 'package:showcase_project/features/widgets/button/app_button.dart';

class AuthScreenWidget extends StatelessWidget {
  const AuthScreenWidget({
    super.key,
    required this.authPhoneController,
    required this.loginController,
    required this.isLoadingListenable,
    required this.isLoginModeListenable,
    required this.onSubmit,
    required this.onToggleMode,
    required this.sendCodeButtonEnable,
    required this.errorListenable,
  });

  final AppTextController authPhoneController;
  final AppTextController loginController;
  final EntityValueListenable<bool> isLoadingListenable;
  final EntityValueListenable<bool> isLoginModeListenable;
  final EntityValueListenable<bool> sendCodeButtonEnable;
  final EntityValueListenable<String?> errorListenable;
  final VoidCallback onSubmit;
  final VoidCallback onToggleMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Text('Habbitsss', style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
        Spacer(),
        EntityStateNotifierBuilder(
          listenableEntityState: errorListenable,
          builder: (context, data) {
            if (data == null) return SizedBox();
            return Text(data, style: context.textStyles.body1.copyWith(color: context.colors.error));
          },
        ),

        // Поле телефона (разное для логина и регистрации, чтобы сохранять стейт)
        AppTextField(controller: authPhoneController, keyboardType: TextInputType.phone),
        SizedBox(height: 16),
        // Кнопка переключения режима
        AppButton.textLike(text: "Нет аккаунта? Зарегистрируйтесь", onTap: onToggleMode),

        const Spacer(),

        const SizedBox(height: 16),

        // Кнопка подтверждения
        DoubleEntityStateNotifierBuilder<bool, bool>(
          firstListenable: isLoadingListenable,
          secondListenable: sendCodeButtonEnable,
          builder: (context, isLoading, isPhoneCorrect) {
            final loading = isLoading ?? false;
            final correct = isPhoneCorrect ?? false;
            return AppButton.primaryFilled(
              text: "Получить код",
              isEnabled: !loading && correct,
              isExpanded: true,
              onTap: onSubmit,
            );
          },
        ),
      ],
    );
  }
}
