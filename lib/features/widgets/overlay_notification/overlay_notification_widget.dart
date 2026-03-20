import 'package:flutter/material.dart';
import 'package:overlay_notifications/overlay_notifications.dart';

class AccentNotification extends IOverlayNotificationModel {
  AccentNotification({required String text})
    : super(
        animationCompleteCallback: () {},
        duration: const Duration(seconds: 3),
        notificationColor: Colors.blueAccent,
        widget: Text(text),
      );
}
