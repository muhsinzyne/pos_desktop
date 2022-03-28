import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class ThemeTextUnderLine extends StatelessWidget {
  const ThemeTextUnderLine({
    Key? key,
    this.width = double.infinity,
    this.color = AppColors.greenIconColor,
    this.stroke = 2,
  }) : super(key: key);

  final double width;
  final double stroke;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: stroke,
      color: color,
      width: width,
    );
  }
}
