// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/home/controllers/delivery_home_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/dropdown.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/infobox.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/quicklink.dart';
import 'package:posdelivery/models/constants.dart';

class DeliveryHomeScreen extends GetView<DeliveryHomeScreenController> {
  DeliveryHomeScreen({Key? key}) : super(key: key);

  final List<String> _dropdownValues = [
    "Today",
    "Two",
    "Three",
    "Four",
    "Five"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dashboard",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff3C3D56)),
                        ),
                        DropdownDelivey(dropdownValues: _dropdownValues),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoBox(
                          boxColor: Color(0xff4911C3),
                          title: "STORES SERVED",
                          value: "00",
                        ),
                        InfoBox(
                          boxColor: Color(0xff5F0BB3),
                          title: "STORES PENDING",
                          value: "00",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoBox(
                          boxColor: Color(0xff5F0BB3),
                          title: "ORDER VALUE",
                          value: "00",
                        ),
                        InfoBox(
                          boxColor: Color(0xff4911C3),
                          title: "RETURN VALUE",
                          value: "00",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoBox(
                          boxColor: Color(0xff4911C3),
                          title: "STOCK VALUE",
                          value: "00",
                        ),
                        InfoBox(
                          boxColor: Color(0xff5F0BB3),
                          title: "CASH IN HAND",
                          value: "00",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        "Quick Links",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff3C3D56)),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.deliverySales);
                      },
                      child: QuickLink(
                        title: "Sales",
                        iconData: FontAwesomeIcons.tag,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.deliveryAddStoreManullay);
                      },
                      child: QuickLink(
                        title: "Stores",
                        iconData: Icons.storefront_outlined,
                      ),
                    ),
                    QuickLink(
                      title: "Cash Register",
                      iconData: Icons.payments_outlined,
                    ),
                    QuickLink(
                      title: "Stock Register",
                      iconData: FontAwesomeIcons.clipboard,
                    ),
                    QuickLink(
                      title: "Settings",
                      iconData: Icons.settings_outlined,
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
