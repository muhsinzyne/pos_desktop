import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class UINotification {
  static const Duration defaultDuration = Duration(seconds: 3);

  static showNotification({
    String? title,
    Color? color,
    Duration? duration,
  }) {
    color ??= Colors.red;
    title ??= '';
    showSimpleNotification(
      Text(title),
      background: color,
    );
  }

  static showCustomLoading() {
    Widget custom = Container(
      width: Get.size.width / 5,
      height: Get.size.width / 5,
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(),
        ),
      ),
    );
    SmartDialog.show(widget: custom);
  }

  static showLoading({String? msg, bool backDismiss = true}) {
    SmartDialog.showLoading(
      msg: (msg == null) ? 'please_wait'.tr : msg,
      background: AppColors.primary,
      backDismiss: backDismiss,
    );
  }

  static hideLoading() {
    SmartDialog.dismiss();
  }
}
