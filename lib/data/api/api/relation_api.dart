import 'package:dio/dio.dart';
import 'package:showcase_project/data/models/remote/models.dart';

abstract class IRelationApi {
  Future<void> sendFriendRequest(CreateRelationRequest request);

  Future<void> sendRelationRequest(CreateRelationRequest request);

  Future<void> replyToRelationRequest(ReplyRelationRequest request);

  Future<void> deleteFriend(DeleteRelationRequest request);

  Future<void> breakRelation(DeleteRelationRequest request);
}

class RelationApi implements IRelationApi {
  RelationApi({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> sendFriendRequest(CreateRelationRequest request) async {
    await _post('/user/relations/friend-request', request.toJson());
  }

  @override
  Future<void> sendRelationRequest(CreateRelationRequest request) async {
    await _post('/user/relations/relation-request', request.toJson());
  }

  @override
  Future<void> replyToRelationRequest(ReplyRelationRequest request) async {
    await _post('/user/relations/reply', request.toJson());
  }

  @override
  Future<void> deleteFriend(DeleteRelationRequest request) async {
    await _delete('/user/relations/friend', request.toJson());
  }

  @override
  Future<void> breakRelation(DeleteRelationRequest request) async {
    await _delete('/user/relations/relation', request.toJson());
  }

  Future<void> _post(String path, Map<String, dynamic> data) async {
    try {
      await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> _delete(String path, Map<String, dynamic> data) async {
    try {
      await _dio.delete(path, data: data);
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
