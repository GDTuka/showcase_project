import 'package:showcase_project/data/api/api/habbit_api.dart';
import 'package:showcase_project/data/models/remote/models.dart';

abstract interface class IHabbitRepository {
  Future<HabbitDto> createHabbit({
    required String title,
    required String description,
    required int complitionInPeriodCount,
    required String complitionPeriod,
  });

  Future<String> markCompletion({
    required int habbitId,
    required String complition,
    required String complitedAt,
    required String? note,
  });

  Future<String> toggleArchive({required int habbitId, required bool archived});

  Future<String> sendSharedRequest({required int habbitId, required int targetUserId});

  Future<SharedHabbitRequestsResponse> getSharedRequests({int? limit, int? offset, bool? accepted});
}

class HabbitRepository implements IHabbitRepository {
  HabbitRepository({required IHabbitApi habbitApi}) : _habbitApi = habbitApi;

  final IHabbitApi _habbitApi;

  @override
  Future<HabbitDto> createHabbit({
    required String title,
    required String description,
    required int complitionInPeriodCount,
    required String complitionPeriod,
  }) async {
    final request = CreateHabbitRequest(
      title: title,
      description: description,
      complitionInPeriodCount: complitionInPeriodCount,
      complitionPeriod: complitionPeriod,
    );
    return _habbitApi.createHabbit(request);
  }

  @override
  Future<String> markCompletion({
    required int habbitId,
    required String complition,
    required String complitedAt,
    required String? note,
  }) async {
    final response = await _habbitApi.markCompletion(
      habbitId: habbitId,
      request: MarkHabbitCompletionRequest(complition: complition, complitedAt: complitedAt, note: note),
    );
    return response.message;
  }

  @override
  Future<String> toggleArchive({required int habbitId, required bool archived}) async {
    final response = await _habbitApi.toggleArchive(
      habbitId: habbitId,
      request: ToggleHabbitArchiveRequest(archived: archived),
    );
    return response.message;
  }

  @override
  Future<String> sendSharedRequest({required int habbitId, required int targetUserId}) async {
    final response = await _habbitApi.sendSharedRequest(
      habbitId: habbitId,
      request: SendSharedHabbitRequest(targetUserId: targetUserId),
    );
    return response.message;
  }

  @override
  Future<SharedHabbitRequestsResponse> getSharedRequests({int? limit, int? offset, bool? accepted}) async {
    final request = GetSharedHabbitRequestsRequest(limit: limit, offset: offset, accepted: accepted);
    return _habbitApi.getSharedRequests(request);
  }
}
