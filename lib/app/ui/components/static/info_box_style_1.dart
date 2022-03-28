import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/styles.dart';

class InfoBoxStyle1 extends StatelessWidget {
  final Color color;
  final IconData? icon;
  final String number;
  final String valuePrefix;
  final String value;
  final String description;
  final List<Widget>? blockItem;
  const InfoBoxStyle1({
    Key? key,
    this.color = Colors.white,
    this.icon,
    this.number = '',
    this.blockItem,
    this.valuePrefix = '',
    this.value = '',
    this.description = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      color: color,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            value,
                            style: kBaseTextStyle.copyWith(
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 2),
                          Text(
                            valuePrefix,
                            style: kBaseTextStyle.copyWith(
                              fontSize: 12,
                              fontFamily: fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Icon(
                        icon ?? Icons.info,
                        size: 28,
                        color: AppColors.greenIconColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: AutoSizeText(
                    description,
                    style: kBaseTextStyle.copyWith(
                        fontFamily: fontFamily, fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
