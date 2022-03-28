import 'package:flutter/material.dart';
import 'package:posdelivery/app/modules/splash/views/pre_splash_screen.dart';

class PreApp extends StatelessWidget {
  const PreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PreSplashScreen(),
    );
  }
}
