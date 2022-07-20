import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';

class HistoryItemDelivery extends StatelessWidget {
  final String title;
  final String date;
  final String price;
  final double iconSize;
  final Color iconColor;

  const HistoryItemDelivery({
    Key? key,
    required this.title,
    required this.date,
    required this.price,
    this.iconColor = AppColors.deliveryPrimary,
    this.iconSize = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                    color: iconColor, borderRadius: BorderRadius.circular(7)),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CustomTextStyle.mainTitle
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    date,
                    style: CustomTextStyle.mainTitle
                        .copyWith(fontSize: 14, color: Colors.black26),
                  )
                ],
              ),
            ],
          ),
          Text(
            price,
            style: CustomTextStyle.mainTitle
                .copyWith(fontSize: 17, fontWeight: FontWeight.w500),
          )
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Divider(
        thickness: 1,
        color: Colors.black26,
      ),
      SizedBox(
        height: 15,
      ),
    ]);
  }
}
