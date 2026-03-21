import 'package:evvm/evvm.dart';
import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/screens/profile/profile_vm.dart';
import 'package:showcase_project/features/theme/theme.dart';
import 'package:showcase_project/features/widgets/avatar_widget.dart';
import 'package:showcase_project/features/widgets/button/app_button.dart';

class ProfileView extends WidgetView<ProfileVM> {
  const ProfileView({super.key}) : super(profileVMF);

  @override
  Widget build(ProfileVM vm, BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Профиль')),
      body: EntityStateNotifierBuilder(
        listenableEntityState: vm.userListenable,
        builder: (context, user) {
          if (user == null) return SizedBox();
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    InkWell(
                      onTap: vm.onAvatarTap,
                      child: AvatarWidget(imageUrl: user.avatar, size: .s90),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text('@${user.login}', style: context.textStyles.headline3),
                        SizedBox(height: 8),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 16 - 32 - 120,
                          child: user.profile?.status == null
                              ? AppButton.textLike(text: 'Добавьте статус', onAsyncTap: vm.onStatusTap)
                              : InkWell(onTap: vm.onStatusTap, child: Text(user.profile?.status ?? 'Добавьте статус')),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    EntityStateNotifierBuilder(
                      listenableEntityState: vm.userPartner,
                      builder: (context, partner) {
                        if (partner == null) return SizedBox();
                        return Row(
                          spacing: 8,
                          children: [
                            Text('Ваш партнёр:'),
                            AvatarWidget(imageUrl: partner.avatar, size: .s30),
                            InkWell(onTap: vm.onPartnerTap, child: Text('@${partner.login}')),
                          ],
                        );
                      },
                    ),
                    SizedBox(width: 16),
                    // TODO(): Добавить иконку с количеством друзей
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
