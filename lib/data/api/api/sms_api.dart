import 'package:dio/dio.dart';
import 'package:showcase_project/data/models/remote/models.dart';

abstract class ISmsApi {
  Future<void> sendSmsCode(SendSmsCodeRequest request);

  Future<bool> checkSmsCode(SmsCheckRequest request);
}

class SmsApi implements ISmsApi {
  SmsApi({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> sendSmsCode(SendSmsCodeRequest request) async {
    try {
      await _dio.post('/user/sms/send', data: request.toJson());
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<bool> checkSmsCode(SmsCheckRequest request) async {
    try {
      final response = await _dio.post('/user/sms/check', data: request.toJson());
      return response.data['success'] as bool;
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
