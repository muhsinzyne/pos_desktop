// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/dropdown.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/history_item.dart';
import 'package:posdelivery/models/constants.dart';

class DeliveryRegisterHistoryScreen extends StatelessWidget {
  DeliveryRegisterHistoryScreen({Key? key}) : super(key: key);
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
                                  Text(
                                    "Payment",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "History",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              DropdownDelivey(dropdownValues: _dropdownValues)
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          HistoryItemDelivery(
                            title: "Opened",
                            price: "8788.43",
                            date: "22 March 2022, 12:38 pm",
                            iconSize: 45,
                          ),
                          HistoryItemDelivery(
                            title: "Closed",
                            price: "8788.43",
                            date: "22 March 2022, 12:38 pm",
                            iconSize: 45,
                            iconColor: Color(0xffFF6565),
                          ),
                          HistoryItemDelivery(
                            title: "Opened",
                            price: "8788.43",
                            date: "22 March 2022, 12:38 pm",
                            iconSize: 45,
                          ),
                          HistoryItemDelivery(
                            title: "Closed",
                            price: "8788.43",
                            date: "22 March 2022, 12:38 pm",
                            iconSize: 45,
                            iconColor: Color(0xffFF6565),
                          ),
                          HistoryItemDelivery(
                            title: "Opened",
                            price: "8788.43",
                            date: "22 March 2022, 12:38 pm",
                            iconSize: 45,
                          ),
                          HistoryItemDelivery(
                            title: "Closed",
                            price: "8788.43",
                            date: "22 March 2022, 12:38 pm",
                            iconSize: 45,
                            iconColor: Color(0xffFF6565),
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
