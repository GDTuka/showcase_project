import 'dart:io';

import 'package:flutter/material.dart';
import 'package:showcase_project/features/theme/theme.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

abstract class MediaPicker {
  static Future<File?> pickSingleImage(BuildContext context) async {
    final res = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: 1,
        specialItems: [
          SpecialItem(
            position: .append,
            builder: (context, path, permissionState) {
              return InkWell(
                onTap: () => MediaCameraPicker.pickFromCamera(context),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(),
                  child: Center(child: Icon(Icons.camera_alt, color: context.colors.primary)),
                ),
              );
            },
          ),
        ],
        textDelegate: _RussianAssetPickerTextDelegate(),
      ),
    );

    final entity = res?.first;

    if (entity == null) return null;

    final file = await entity.file;

    return file;
  }

  static Future<List<File>?> pickMultiImage(BuildContext context) async {
    final res = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: 9,
        specialItems: [
          SpecialItem(
            position: .append,
            builder: (context, path, permissionState) {
              return InkWell(
                onTap: () async {
                  final res = await MediaCameraPicker.pickFromCamera(context);

                  if (res != null) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop([res]);
                  }
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(),
                  child: Center(child: Icon(Icons.camera_alt, color: context.colors.surface)),
                ),
              );
            },
          ),
        ],
        textDelegate: _RussianAssetPickerTextDelegate(),
      ),
    );

    if (res == null) return null;

    final files = <File>[];

    for (int i = 0; i < res.length; i++) {
      final entity = res[i];

      final file = await entity.file;

      if (file != null) {
        files.add(file);
      }
    }

    return files;
  }
}

abstract class MediaCameraPicker {
  static Future<AssetEntity?> pickFromCamera(BuildContext context) async {
    final res = await CameraPicker.pickFromCamera(
      context,
      pickerConfig: const CameraPickerConfig(enableRecording: false, textDelegate: _RussianCameraPickerTextDelegate()),
    );
    return res;
  }
}

class _RussianCameraPickerTextDelegate extends CameraPickerTextDelegate {
  const _RussianCameraPickerTextDelegate();

  @override
  String get languageCode => 'ru';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get shootingTips => 'Нажмите, чтобы сделать фото.';

  @override
  String get shootingWithRecordingTips => 'Нажмите, чтобы сделать фото. Удерживайте, чтобы записать видео.';

  @override
  String get shootingOnlyRecordingTips => 'Удерживайте, чтобы записать видео.';

  @override
  String get shootingTapRecordingTips => 'Нажмите, чтобы записать видео.';

  @override
  String get loadFailed => 'Загрузка не удалась';

  @override
  String get loading => 'Загрузка...';

  @override
  String get saving => 'Сохранение...';

  @override
  String get sActionManuallyFocusHint => 'ручная фокусировка';

  @override
  String get sActionPreviewHint => 'предпросмотр';

  @override
  String get sActionRecordHint => 'запись';

  @override
  String get sActionShootHint => 'сделать фото';

  @override
  String get sActionShootingButtonTooltip => 'кнопка съемки';

  @override
  String get sActionStopRecordingHint => 'остановить запись';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value) => value.name;

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    return '${sCameraLensDirectionLabel(value)} предпросмотр камеры';
  }

  @override
  String sFlashModeLabel(FlashMode mode) => 'Режим вспышки: ${mode.name}';

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value) =>
      'Переключитесь на ${sCameraLensDirectionLabel(value)} камеру';
}

class _RussianAssetPickerTextDelegate extends AssetPickerTextDelegate {
  _RussianAssetPickerTextDelegate();
  @override
  String get languageCode => 'ru';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get cancel => 'Отмена';

  @override
  String get edit => 'Редактировать';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get livePhotoIndicator => 'LIVE';

  @override
  String get loadFailed => 'Загрузка не удалась';

  @override
  String get original => 'Оригинал';

  @override
  String get preview => 'Предпросмотр';

  @override
  String get select => 'Выбрать';

  @override
  String get emptyList => 'Список пуст';

  @override
  String get unSupportedAssetType => 'Неподдерживаемый тип файла HEIC.';

  @override
  String get unableToAccessAll => 'Невозможно получить доступ ко всем файлам на устройстве';

  @override
  String get viewingLimitedAssetsTip => 'Просмотр только тех файлов и альбомов, к которым предоставлен доступ.';

  @override
  String get changeAccessibleLimitedAssets => 'Нажмите для обновления доступных файлов';

  @override
  String get accessAllTip =>
      'Приложение может получить доступ только к некоторым файлам на устройстве. '
      'Перейдите в настройки системы и разрешите приложению доступ ко всем файлам на устройстве.';

  @override
  String get goToSystemSettings => 'Перейти в настройки системы';

  @override
  String get accessLimitedAssets => 'Продолжить с ограниченным доступом';

  @override
  String get accessiblePathName => 'Доступные файлы';

  @override
  String get sTypeAudioLabel => 'Аудио';

  @override
  String get sTypeImageLabel => 'Изображение';

  @override
  String get sTypeVideoLabel => 'Видео';

  @override
  String get sTypeOtherLabel => 'Другой файл';

  @override
  String get sActionPlayHint => 'воспроизвести';

  @override
  String get sActionPreviewHint => 'предпросмотр';

  @override
  String get sActionSelectHint => 'выбрать';

  @override
  String get sActionSwitchPathLabel => 'сменить путь';

  @override
  String get sActionUseCameraHint => 'использовать камеру';

  @override
  String get sNameDurationLabel => 'продолжительность';

  @override
  String get sUnitAssetCountLabel => 'количество';
}
