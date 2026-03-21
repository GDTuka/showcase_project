import 'package:dio/dio.dart';
import 'package:evvm/evvm.dart';
import 'package:evvm/evvm_helper.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/data/models/remote/models.dart';
import 'package:showcase_project/di/scopes/global_scope.dart';
import 'package:showcase_project/di/scopes/user_scope.dart';
import 'package:showcase_project/domain/image_repository.dart';
import 'package:showcase_project/domain/user_repository.dart';
import 'package:showcase_project/features/screens/profile/profile_view.dart';
import 'package:showcase_project/features/utils/media_picker/media_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

abstract interface class IProfileVM implements IViewModel {
  EntityValueListenable<UserDto?> get userListenable;

  EntityValueListenable<UserDto?> get userPartner;

  /// Открывает аватар на полный экран
  /// Если аватара нет запускает логику установки аватара
  Future<void> onAvatarTap();

  /// Открывает окно изменения статуса
  Future<void> onStatusTap();

  /// Отправляет пользователя на экран настроек
  void onSettingsTap();

  /// Отправляет пользователя на экран списка друзей
  void onFriendsTap();

  /// Отправляет пользователян в профиль пользователя с которым у него отношения
  void onPartnerTap();
}

ProfileVM profileVMF(BuildContext context) {
  return ProfileVM(userRepository: context.user.userRepository, imageRepository: context.global.imageRepository);
}

class ProfileVM extends ViewModel<ProfileView> implements IProfileVM {
  ProfileVM({required IUserRepository userRepository, required IImageRepository imageRepository})
    : _userRepository = userRepository,
      _imageRepository = imageRepository;
  late final IUserRepository _userRepository;
  late final IImageRepository _imageRepository;

  final _userEntity = EntityStateNotifier<UserDto?>();

  final _userPartner = EntityStateNotifier<UserDto?>();

  @override
  EntityValueListenable<UserDto?> get userListenable => _userEntity;

  @override
  EntityValueListenable<UserDto?> get userPartner => _userPartner;

  void _onUserNotifierUpdate() {
    _userEntity.content(context.user.userRepository.userNotifier.value);
  }

  @override
  void init() {
    context.user.userRepository.userNotifier.addListener(_onUserNotifierUpdate);
    _userEntity.content(context.user.userRepository.userNotifier.value);
    _searchUserPartner();
    super.init();
  }

  Future<void> _searchUserPartner() async {
    _userPartner.loading();
    try {
      final partner = await _userRepository.searchUsers(relationType: 'relation', limit: 1);
      if (partner.users.firstOrNull != null) {
        _userPartner.content(partner.users.first);
      }
      _userPartner.content(null);
    } on DioException {
      _userPartner.error();
    }
  }

  @override
  Future<void> onAvatarTap() async {
    if (_userEntity.value.data?.avatar == null) {
      try {
        await _uploadAvatar();
      } on Object {
        // TODO() add handle
      }
    } else {
      await showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(leading: Icon(Icons.fullscreen), title: Text('Открыть полное фото'), onTap: () {}),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Изменить аватар'),
                  onTap: () async {
                    await _uploadAvatar();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Future<void> _uploadAvatar() async {
    AssetPicker.permissionCheck(
      requestOption: PermissionRequestOption(androidPermission: AndroidPermission(type: .all, mediaLocation: true)),
    );
    final image = await MediaPicker.pickSingleImage(context);
    if (image == null) return;
    await _imageRepository.uploadAvatar(image);
    await _userRepository.getCurrentUser();
  }

  @override
  void onFriendsTap() {
    // TODO: implement onFriendsTap
  }

  @override
  void onPartnerTap() {
    // TODO: implement onPartnerTap
  }

  @override
  void onSettingsTap() {
    // TODO: implement onSettingsTap
  }

  @override
  Future<void> onStatusTap() {
    // TODO: implement onStatusTap
    throw UnimplementedError();
  }
}
