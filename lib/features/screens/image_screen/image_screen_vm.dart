import 'package:evvm/evvm.dart';
import 'package:flutter/material.dart';
import 'package:showcase_project/features/screens/image_screen/image_screen_view.dart';

abstract interface class IImageScreenVM implements IViewModel {}

ImageScreenVM imageScreenVMF(BuildContext context) {
  return ImageScreenVM();
}

class ImageScreenVM extends ViewModel<ImageScreenView> implements IImageScreenVM {}
