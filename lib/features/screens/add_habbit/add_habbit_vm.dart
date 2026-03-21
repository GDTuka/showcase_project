import 'package:evvm/evvm.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/screens/add_habbit/add_habbit_view.dart';

abstract interface class IAddHabbitVM implements IViewModel {
}

AddHabbitVM addHabbitVMF(BuildContext context) {
  return AddHabbitVM();
}

class AddHabbitVM extends ViewModel<AddHabbitView> implements IAddHabbitVM {}
