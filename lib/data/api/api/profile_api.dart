import 'package:dio/dio.dart';
import 'package:showcase_project/data/models/remote/models.dart';

abstract class IProfileApi {
  Future<void> updateNames(UpdateProfileNamesRequest request);

  Future<void> updateStatus(UpdateProfileStatusRequest request);

  Future<void> updateBirthDate(UpdateProfileBirthDateRequest request);

  Future<void> updateGender(UpdateProfileGenderRequest request);

  Future<void> updatePrivateProfile(UpdateProfilePrivateRequest request);
}

class ProfileApi implements IProfileApi {
  ProfileApi({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> updateNames(UpdateProfileNamesRequest request) async {
    await _patch('/user/profile/names', request.toJson());
  }

  @override
  Future<void> updateStatus(UpdateProfileStatusRequest request) async {
    await _patch('/user/profile/status', request.toJson());
  }

  @override
  Future<void> updateBirthDate(UpdateProfileBirthDateRequest request) async {
    await _patch('/user/profile/birth-date', request.toJson());
  }

  @override
  Future<void> updateGender(UpdateProfileGenderRequest request) async {
    await _patch('/user/profile/gender', request.toJson());
  }

  @override
  Future<void> updatePrivateProfile(UpdateProfilePrivateRequest request) async {
    await _patch('/user/profile/private', request.toJson());
  }

  Future<void> _patch(String path, Map<String, dynamic> data) async {
    try {
      await _dio.patch(path, data: data);
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
