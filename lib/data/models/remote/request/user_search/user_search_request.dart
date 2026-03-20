/// Модель данных для поиска пользователей
class UserSearchRequest {
  /// Поиск по логину (частичное совпадение)
  final String? login;
  
  /// Фильтр по типу отношений
  final String? relationType;
  
  /// Количество результатов (по умолчанию: 10)
  final int? limit;
  
  /// Смещение для пагинации (по умолчанию: 0)
  final int? offset;

  /// Создает модель запроса поиска пользователей
  UserSearchRequest({
    this.login,
    this.relationType,
    this.limit,
    this.offset,
  });

  /// Преобразует модель в query параметры для URL
  Map<String, dynamic> toQueryParams() {
    return {
      if (login != null) 'login': login,
      if (relationType != null) 'relation_type': relationType,
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
    };
  }
}
