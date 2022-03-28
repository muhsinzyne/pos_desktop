import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class ChamberRowLogo extends StatelessWidget {
  const ChamberRowLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
            flex: 2,
            child: Container(
              child: Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  color: AppColors.primary,
                ),
              ),
            )),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}
