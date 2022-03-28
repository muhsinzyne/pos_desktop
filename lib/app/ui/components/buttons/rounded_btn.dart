import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class CRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final Color color, textColor;
  final double width;
  final BorderRadius? borderRadius;
  final double fontSize;
  const CRoundedButton({
    Key? key,
    this.text = 'app_title',
    this.onPress,
    this.color = AppColors.primary,
    this.textColor = AppColors.secondary,
    this.width = 300,
    this.borderRadius,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: width,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w500)),
    );
  }
}
