import 'package:dio/dio.dart';
import 'package:showcase_project/data/models/remote/models.dart';

abstract class IHabbitApi {
  Future<HabbitDto> createHabbit(CreateHabbitRequest request);

  Future<HabbitActionResponse> markCompletion({required int habbitId, required MarkHabbitCompletionRequest request});

  Future<HabbitActionResponse> toggleArchive({required int habbitId, required ToggleHabbitArchiveRequest request});

  Future<HabbitActionResponse> sendSharedRequest({required int habbitId, required SendSharedHabbitRequest request});

  Future<SharedHabbitRequestsResponse> getSharedRequests(GetSharedHabbitRequestsRequest request);
}

class HabbitApi implements IHabbitApi {
  HabbitApi({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<HabbitDto> createHabbit(CreateHabbitRequest request) async {
    try {
      final response = await _dio.post('/habbits', data: request.toJson());
      return HabbitDto.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<HabbitActionResponse> markCompletion({required int habbitId, required MarkHabbitCompletionRequest request}) async {
    try {
      final response = await _dio.post('/habbits/$habbitId/completion', data: request.toJson());
      return HabbitActionResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<HabbitActionResponse> toggleArchive({required int habbitId, required ToggleHabbitArchiveRequest request}) async {
    try {
      final response = await _dio.patch('/habbits/$habbitId/archive', data: request.toJson());
      return HabbitActionResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<HabbitActionResponse> sendSharedRequest({required int habbitId, required SendSharedHabbitRequest request}) async {
    try {
      final response = await _dio.post('/habbits/$habbitId/shared-request', data: request.toJson());
      return HabbitActionResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<SharedHabbitRequestsResponse> getSharedRequests(GetSharedHabbitRequestsRequest request) async {
    try {
      final response = await _dio.get('/habbits/requests', queryParameters: request.toQueryParams());
      return SharedHabbitRequestsResponse.fromJson(response.data as Map<String, dynamic>);
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
