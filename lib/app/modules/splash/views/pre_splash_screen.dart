import 'package:flutter/material.dart';
import 'package:posdelivery/app/modules/splash/views/splash_content.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class PreSplashScreen extends StatelessWidget {
  const PreSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SplashContent(),
    );
  }
}
