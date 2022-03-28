import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/splash/views/splash_content.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreen extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SplashContent(),
    );
  }
}
