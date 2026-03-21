import 'dart:io';

import 'package:dio/dio.dart';
import 'package:showcase_project/data/models/remote/models.dart';

abstract class IImageApi {
  Future<UploadAvatarResponse> uploadAvatar(File file);
}

class ImageApi implements IImageApi {
  ImageApi({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<UploadAvatarResponse> uploadAvatar(File file) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: file.uri.pathSegments.last),
      });
      final response = await _dio.post('/user/avatar', data: formData);
      return UploadAvatarResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['error'] != null) {
      return Exception(data['error']);
    }
    return Exception(e.message ?? 'Unknown API Error');
  }
}
