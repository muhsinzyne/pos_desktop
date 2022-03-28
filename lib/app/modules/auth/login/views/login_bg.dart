import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class BackgroundLogin extends StatelessWidget {
  final Widget? child;
  const BackgroundLogin({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Container(
      color: AppColors.bgLight2,
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          child ?? Container(),
        ],
      ),
    );
  }
}
