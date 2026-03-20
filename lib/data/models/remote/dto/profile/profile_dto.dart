/// Модель данных профиля пользователя
class ProfileDto {
  /// ID пользователя
  final int userId;
  
  /// Имя
  final String firstName;
  
  /// Фамилия
  final String lastName;
  
  /// Отчество (может быть null)
  final String? middleName;
  
  /// Статус
  final String status;
  
  /// Приватный профиль
  final bool privateProfile;
  
  /// Дата рождения
  final DateTime birthDate;
  
  /// Пол
  final String gender;
  
  /// Дата создания
  final DateTime createdAt;
  
  /// Дата обновления
  final DateTime updatedAt;

  /// Создает экземпляр модели профиля
  ProfileDto({
    required this.userId,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.status,
    required this.privateProfile,
    required this.birthDate,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Фабричный метод для создания [ProfileDto] из JSON
  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return ProfileDto(
      userId: json['user_id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      middleName: json['middle_name'] as String?,
      status: json['status'] as String,
      privateProfile: json['private_profile'] as bool,
      birthDate: DateTime.parse(json['birth_date'] as String),
      gender: json['gender'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Преобразует модель в JSON формат
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'status': status,
      'private_profile': privateProfile,
      'birth_date': birthDate.toIso8601String().split('T')[0],
      'gender': gender,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
