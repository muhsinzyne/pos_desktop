import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:posdelivery/app/ui/components/static/info_box_style_1.dart';
import 'package:posdelivery/models/response/auth/current_register_response.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';

class ProfileInfoCardBlock extends StatelessWidget {
  const ProfileInfoCardBlock({
    Key? key,
    this.currentRegisterResponse,
    this.registerCloseSummary,
  }) : super(key: key);

  final CurrentRegisterResponse? currentRegisterResponse;
  final RegisterCloseSummary? registerCloseSummary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: InfoBoxStyle1(
                icon: FontAwesomeIcons.shippingFast,
                valuePrefix: ''.tr,
                value: registerCloseSummary?.saleCount.toString() ?? '0',
                description: 'total_sales'.tr,
              ),
            ),
            Expanded(
              flex: 1,
              child: InfoBoxStyle1(
                icon: FontAwesomeIcons.cashRegister,
                valuePrefix: 'SAR'.tr,
                value: registerCloseSummary!.saleAmount.toStringAsFixed(2),
                description: 'sale_amount'.tr,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: InfoBoxStyle1(
                icon: FontAwesomeIcons.moneyBillAlt,
                valuePrefix: 'SR'.tr,
                value: registerCloseSummary!.openCash.toStringAsFixed(2),
                description: 'open_register'.tr,
              ),
            ),
            Expanded(
              flex: 1,
              child: InfoBoxStyle1(
                icon: FontAwesomeIcons.moneyBill,
                valuePrefix: 'SR'.tr,
                value: registerCloseSummary!.inHandTotal.toStringAsFixed(2),
                description: 'in_hand'.tr,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
