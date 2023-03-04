import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class PendingPaymentItem extends StatelessWidget {
  final Color statusColor;
  final String statusText;
  const PendingPaymentItem({
    Key? key,
    required this.statusColor,
    required this.statusText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: AppColors.newBg, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Store Name",
                  style: CustomTextStyle.mainTitle
                      .copyWith(fontSize: 18, color: AppColors.newPrimary),
                ),
                Text(
                  "Store 1",
                  style: CustomTextStyle.mainTitle
                      .copyWith(fontSize: 18, color: AppColors.newRed),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Invoice",
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  "#98329",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Amount",
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  "5898.00",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Due Date",
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  "22 March 2022",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            // height: 20,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Center(
                child: Container(
                    padding: const EdgeInsets.all(14),
                    child: Text(
                      statusText,
                      style: const TextStyle(color: Colors.white),
                    ))),
          )
        ],
      ),
    );
  }
}
