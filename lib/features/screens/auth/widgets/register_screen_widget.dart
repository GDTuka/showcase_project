import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/theme/theme.dart';
import 'package:showcase_project/features/utils/app_text_field/text_field.dart';
import 'package:showcase_project/features/utils/app_text_field/text_field_controller.dart';
import 'package:showcase_project/features/widgets/button/app_button.dart';

class RegisterScreenWidget extends StatelessWidget {
  const RegisterScreenWidget({
    super.key,
    required this.regPhoneController,
    required this.regCodeController,
    required this.loginController,
    required this.isLoadingListenable,
    required this.errorListenable,
    required this.onSubmit,
    required this.onToggleMode,
    required this.codeSentListenable,
    required this.sendCodeButtonEnableListenable,
  });

  final AppTextController regPhoneController;
  final AppTextController regCodeController;
  final AppTextController loginController;
  final EntityValueListenable<bool> isLoadingListenable;
  final EntityValueListenable<bool> codeSentListenable;
  final EntityValueListenable<String?> errorListenable;
  final EntityValueListenable<bool> sendCodeButtonEnableListenable;
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
        // Если регистрация, показываем поле логина (только для чтения)
        AppTextField(controller: loginController, keyboardType: TextInputType.text, readOnly: true),
        const SizedBox(height: 16),

        AppTextField(
          controller: regPhoneController,
          keyboardType: TextInputType.phone,
          readOnly: true, // Запрещаем редактировать телефон на экране ввода кода
        ),
        const SizedBox(height: 16),

        EntityStateNotifierBuilder(
          listenableEntityState: codeSentListenable,
          builder: (context, data) {
            if (data ?? false) {
              return AppTextField(controller: regCodeController, keyboardType: TextInputType.number);
            }
            return SizedBox();
          },
        ),
        // Кнопка возврата (отменяет состояние ввода кода и переключает режим, если нужно)
        AppButton.primaryOutlined(
          text: 'Есть аккаунт? Авторизуйтесь',
          onTap: onToggleMode, // Используем этот же колбэк или можно добавить отдельный onBack
        ),
        const Spacer(),

        const SizedBox(height: 16),
        TripleEntityStateNotifierBuilder<bool, bool, bool>(
          firstListenable: isLoadingListenable,
          secondListenable: sendCodeButtonEnableListenable,
          thirdListenable: codeSentListenable,
          builder: (context, isLoading, isPhoneCorrect, codeSent) {
            final loading = isLoading ?? false;
            final correct = isPhoneCorrect ?? false;
            return AppButton.primaryFilled(
              text: (codeSent ?? false) ? 'Подтвердить код' : 'Получить код',
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
