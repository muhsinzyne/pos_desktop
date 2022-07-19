import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/splash/controllers/delivery_splash_controller.dart';
import 'package:posdelivery/app/modules/splash/views/splash_content.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class DeliverySplashScreen extends GetView<DeliverySplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SplashContent(),
    );
  }
}
