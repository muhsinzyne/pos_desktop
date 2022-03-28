import 'package:flutter/material.dart';
import 'package:posdelivery/app/locator.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';

class CBottomSheetBtn extends StatelessWidget {
  const CBottomSheetBtn({
    Key? key,
    this.color = AppColors.primary,
    this.onTap = dummyFunction,
    this.textColor = Colors.white,
    this.label = '',
    this.iconColor = Colors.white,
    this.icon,
    this.flex = 1,
  }) : super(key: key);

  final Color color;
  final Function onTap;
  final Color textColor;
  final String label;
  final Color iconColor;
  final IconData? icon;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        child: Material(
          color: color,
          child: InkWell(
            onTap: () => onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          icon != null
                              ? Icon(
                                  icon,
                                  color: iconColor,
                                )
                              : Container(),
                          SizedBox(width: 5),
                          Container(
                            child: Text(
                              label,
                              style: kBaseTextStyle.copyWith(
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
