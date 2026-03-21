import 'package:evvm/evvm.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/screens/profile/profile_view.dart';

abstract interface class IProfileVM implements IViewModel {}

ProfileVM profileVMF(BuildContext context) {
  return ProfileVM();
}

class ProfileVM extends ViewModel<ProfileView> implements IProfileVM {}
