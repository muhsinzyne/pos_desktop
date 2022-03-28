import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';
import 'package:posdelivery/services/app_service.dart';

class EmployeeNameRow extends StatelessWidget {
  const EmployeeNameRow({
    Key? key,
    required this.appService,
  }) : super(key: key);

  final AppService appService;

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(2),
            color: Colors.white,
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            child: AutoSizeText(
                              appService.employeeInfo!.userInfo!.empFullName ??
                                  '',
                              style: kBaseTextStyle.copyWith(
                                  fontSize: 22,
                                  fontFamily: arabic,
                                  color: AppColors.textBlue),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.location_pin,
                          size: 16,
                          color: AppColors.textBlue,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          appService.employeeInfo!.userInfo!.department ?? '',
                          style: kBaseTextStyle.copyWith(
                              fontSize: 16,
                              fontFamily: arabic,
                              color: Colors.black.withOpacity(.7)),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
