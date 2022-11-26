import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/controllers/base_controller.dart';

class DeliveryPaymentInvoiceScreenController extends BaseGetXController {
  cacheOrInsert() {
    Get.defaultDialog(
      title: "",
      content: SizedBox(
        width: 300,
        child: Column(
          children: [
            SvgPicture.asset("assets/svg/tick.svg",
                semanticsLabel: 'Acme Logo'),
            SizedBox(
              height: 10,
            ),
            Text("Demo: invoice payment Completed"),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Get.offNamedUntil(Routes.deliveryPaymentHome,
                    ModalRoute.withName(Routes.deliveryPaymentHome));
              },
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deliveryPrimary80,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
