import 'package:showcase_project/data/api/api/relation_api.dart';
import 'package:showcase_project/data/models/remote/models.dart';

/// Интерфейс репозитория для работы с отношениями между пользователями.
abstract interface class IRelationRepository {
  /// Отправляет запрос в друзья пользователю с идентификатором [relatedUserId].
  Future<void> sendFriendRequest({required int relatedUserId});

  /// Отправляет запрос на более близкий тип отношения пользователю [relatedUserId].
  Future<void> sendRelationRequest({required int relatedUserId});

  /// Отвечает на входящий запрос отношения от пользователя [userId]
  /// с новым типом отношения [relationType].
  Future<void> replyToRelationRequest({required int userId, required String relationType});

  /// Удаляет дружбу с пользователем [userId].
  Future<void> deleteFriend({required int userId});

  /// Разрывает отношение с пользователем [userId].
  Future<void> breakRelation({required int userId});
}

/// Репозиторий для работы с отношениями пользователей.
///
/// Инкапсулирует создание request-моделей и делегирует сетевые вызовы в [IRelationApi].
class RelationRepository implements IRelationRepository {
  /// Создает экземпляр репозитория с зависимостью от [IRelationApi].
  RelationRepository({required IRelationApi relationApi}) : _relationApi = relationApi;

  final IRelationApi _relationApi;

  @override
  Future<void> sendFriendRequest({required int relatedUserId}) async {
    await _relationApi.sendFriendRequest(CreateRelationRequest(relatedUserId: relatedUserId));
  }

  @override
  Future<void> sendRelationRequest({required int relatedUserId}) async {
    await _relationApi.sendRelationRequest(CreateRelationRequest(relatedUserId: relatedUserId));
  }

  @override
  Future<void> replyToRelationRequest({required int userId, required String relationType}) async {
    await _relationApi.replyToRelationRequest(ReplyRelationRequest(userId: userId, relationType: relationType));
  }

  @override
  Future<void> deleteFriend({required int userId}) async {
    await _relationApi.deleteFriend(DeleteRelationRequest(userId: userId));
  }

  @override
  Future<void> breakRelation({required int userId}) async {
    await _relationApi.breakRelation(DeleteRelationRequest(userId: userId));
  }
}
