// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/dropdown.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/history_item.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';

class DeliveryPaymentHistoryScreen extends StatelessWidget {
  DeliveryPaymentHistoryScreen({Key? key}) : super(key: key);
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
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Payment",
                                      style: CustomTextStyle.mainTitle),
                                  Text("History",
                                      style: CustomTextStyle.mainTitle),
                                ],
                              ),
                              DropdownDelivey(dropdownValues: _dropdownValues)
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          HistoryItemDelivery(
                            title: "#KKJS45940665 (ref)",
                            price: "8788.43",
                            date: "22 March 2022, 12:38 pm",
                          ),
                          HistoryItemDelivery(
                            title: "#KKJS45940665 (ref)",
                            price: "8788.43",
                            date: "22 March 2022, 12:38 pm",
                          ),
                          HistoryItemDelivery(
                            title: "#KKJS45940665 (ref)",
                            price: "8788.43",
                            date: "22 March 2022, 12:38 pm",
                          ),
                          HistoryItemDelivery(
                            title: "#KKJS45940665 (ref)",
                            price: "8788.43",
                            date: "22 March 2022, 12:38 pm",
                          ),
                          HistoryItemDelivery(
                            title: "#KKJS45940665 (ref)",
                            price: "8788.43",
                            date: "22 March 2022, 12:38 pm",
                          ),
                          HistoryItemDelivery(
                            title: "#KKJS45940665 (ref)",
                            price: "8788.43",
                            date: "22 March 2022, 12:38 pm",
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
