part of '../../models.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileDto {
  /// ID пользователя
  final int userId;

  /// Имя
  final String? firstName;

  /// Фамилия
  final String? secondName;

  /// Отчество (может быть null)
  final String? middleName;

  /// Статус
  final String? status;

  /// Приватный профиль
  final bool privateProfile;

  /// Дата рождения
  final String? birthDate;

  /// Пол
  final String? gender;

  /// Дата создания
  final String createdAt;

  /// Дата обновления
  final String updatedAt;

  /// Создает экземпляр модели профиля
  ProfileDto({
    required this.userId,
    required this.firstName,
    required this.secondName,
    this.middleName,
    required this.status,
    required this.privateProfile,
    required this.birthDate,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Фабричный метод для создания [ProfileDto] из JSON
  factory ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);

  /// Преобразует модель в JSON формат
  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);
}
