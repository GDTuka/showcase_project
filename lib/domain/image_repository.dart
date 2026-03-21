import 'dart:io';

import 'package:showcase_project/data/api/api/image_api.dart';
import 'package:showcase_project/features/utils/flavor.dart';

abstract interface class IImageRepository {
  Future<String> uploadAvatar(File file);

  String? resolveImageUrl(String? imagePath);
}

class ImageRepository implements IImageRepository {
  ImageRepository({required IImageApi imageApi}) : _imageApi = imageApi;

  final IImageApi _imageApi;

  @override
  Future<String> uploadAvatar(File file) async {
    final response = await _imageApi.uploadAvatar(file);
    return response.avatar;
  }

  @override
  String? resolveImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.trim().isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(imagePath);
    if (uri != null && uri.hasScheme) {
      return imagePath;
    }

    final baseUri = Uri.parse(FlavorConfig.apiUrl);
    return baseUri.resolve(imagePath).toString();
  }
}
