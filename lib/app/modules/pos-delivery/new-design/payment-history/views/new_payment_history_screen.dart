import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/payment-history/controllers/new_pending_payments_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/pending-payments/controllers/new_pending_payments_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/quotations/controllers/new_quotations_controller.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/store/controllers/new_store_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/app_bar.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/dropdown.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/history_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/pending_payment_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/store_category_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/store_item.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class NewPaymentHistoryScreen
    extends GetView<NewPaymentHistoryScreenController> {
  bool validate = false;
  NewPaymentHistoryScreen({Key? key}) : super(key: key);
  final List<String> _dropdownValues = [
    "Brand",
    "Two",
    "Three",
    "Four",
    "Five"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.newSecondary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SvgPicture.asset(
                "assets/svg/menu.svg",
                height: 30,
                color: AppColors.newIconColor,
                width: 30,
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(icon: SizedBox(), label: ""),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => Get.back(),
              child: SvgPicture.asset(
                "assets/svg/back.svg",
                height: 30,
                width: 30,
              ),
            ),
            label: '',
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FittedBox(
          child: FloatingActionButton(
            child: Container(),
            //  SvgPicture.asset(

            //   "assets/svg/qr.svg",
            //   fit: BoxFit.fitHeight,
            // ),
            backgroundColor: AppColors.newSecondary,
            onPressed: null,
          ),
        ),
      ),
      appBar: DeliveryAppBar(
        appBar: AppBar(),
      ),
      backgroundColor: AppColors.newBg,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text("Payment History".toUpperCase(),
                                style: CustomTextStyle.mainTitle
                                    .copyWith(color: const Color(0xff454E52))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 30,
                        // width: 100,
                        child: DropdownDelivey(dropdownValues: _dropdownValues),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Expanded(
                      flex: 15,
                      child: Material(
                        elevation: 5,
                        child: Container(
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.0),
                              topLeft: Radius.circular(8.0),
                            ),
                          ),
                          padding:
                              const EdgeInsets.only(right: 5, left: 5, top: 10),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    SizedBox(
                                      height: 35,
                                    ),
                                    HistoryItemDelivery(
                                        title: "#KKJS45940665 (ref) ",
                                        date: "22 March 2022, 12:38 pm",
                                        iconColor: AppColors.newBlue,
                                        price: "8888.88"),
                                    HistoryItemDelivery(
                                        title: "#KKJS45940665 (ref) ",
                                        date: "22 March 2022, 12:38 pm",
                                        iconColor: AppColors.newBlue,
                                        price: "8888.88"),
                                    HistoryItemDelivery(
                                        title: "#KKJS45940665 (ref) ",
                                        date: "22 March 2022, 12:38 pm",
                                        iconColor: AppColors.newBlue,
                                        price: "8888.88"),
                                    HistoryItemDelivery(
                                        title: "#KKJS45940665 (ref) ",
                                        date: "22 March 2022, 12:38 pm",
                                        iconColor: AppColors.newBlue,
                                        price: "8888.88"),
                                    HistoryItemDelivery(
                                        title: "#KKJS45940665 (ref) ",
                                        date: "22 March 2022, 12:38 pm",
                                        iconColor: AppColors.newBlue,
                                        price: "8888.88"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
