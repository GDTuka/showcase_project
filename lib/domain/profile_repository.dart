import 'package:showcase_project/data/api/api/profile_api.dart';
import 'package:showcase_project/data/models/remote/models.dart';

abstract interface class IProfileRepository {
  Future<void> updateNames({required String? firstName, required String? secondName, required String? middleName});

  Future<void> updateStatus({required String? status});

  Future<void> updateBirthDate({required String? birthDate});

  Future<void> updateGender({required String? gender});

  Future<void> updatePrivateProfile({required bool privateProfile});
}

class ProfileRepository implements IProfileRepository {
  ProfileRepository({required IProfileApi profileApi}) : _profileApi = profileApi;

  final IProfileApi _profileApi;

  @override
  Future<void> updateNames({
    required String? firstName,
    required String? secondName,
    required String? middleName,
  }) async {
    final request = UpdateProfileNamesRequest(firstName: firstName, secondName: secondName, middleName: middleName);
    await _profileApi.updateNames(request);
  }

  @override
  Future<void> updateStatus({required String? status}) async {
    await _profileApi.updateStatus(UpdateProfileStatusRequest(status: status));
  }

  @override
  Future<void> updateBirthDate({required String? birthDate}) async {
    await _profileApi.updateBirthDate(UpdateProfileBirthDateRequest(birthDate: birthDate));
  }

  @override
  Future<void> updateGender({required String? gender}) async {
    await _profileApi.updateGender(UpdateProfileGenderRequest(gender: gender));
  }

  @override
  Future<void> updatePrivateProfile({required bool privateProfile}) async {
    await _profileApi.updatePrivateProfile(UpdateProfilePrivateRequest(privateProfile: privateProfile));
  }
}
