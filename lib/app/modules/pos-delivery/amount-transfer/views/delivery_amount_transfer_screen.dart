// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/dropdown.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import '../../../../../models/constants.dart';
import 'package:flutter_switch/flutter_switch.dart';

class DeliveryAmountTransferScreen extends StatefulWidget {
  DeliveryAmountTransferScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAmountTransferScreen> createState() =>
      _DeliveryAmountTransferScreenState();
}

class _DeliveryAmountTransferScreenState
    extends State<DeliveryAmountTransferScreen> {
  final List<String> _dropdownValues = [
    "Today",
    "Two",
    "Three",
    "Four",
    "Five"
  ];
  bool status = false;
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Amount",
                                      style: CustomTextStyle.mainTitle,
                                    ),
                                    Text(
                                      "Transfer",
                                      style: CustomTextStyle.mainTitle,
                                    ),
                                  ],
                                ),
                                FlutterSwitch(
                                  // activeText: "null.",
                                  inactiveText: "Send",

                                  value: status,
                                  valueFontSize: 12.0,
                                  width: 80,
                                  borderRadius: 30.0,
                                  showOnOff: true,
                                  toggleColor: AppColors.deliverySecondaryLight,
                                  activeColor: AppColors.deliveryPrimary,
                                  inactiveTextColor: Color(0xff5E6164),
                                  inactiveColor: Colors.grey[300]!,
                                  onToggle: (val) {
                                    setState(() {
                                      status = val;
                                    });
                                  },
                                ),
                              ]),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Amount"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Purpose"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Transfer Mode"),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: DropdownButton(
                                  underline: SizedBox.shrink(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  iconSize: 23,

                                  items: _dropdownValues
                                      .map((value) => DropdownMenuItem(
                                            child: Text(value),
                                            value: value,
                                          ))
                                      .toList(),
                                  //   onChanged: (String value) {},
                                  isExpanded: true,
                                  value: _dropdownValues.first,
                                  onChanged: (String? value) {},
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Transaction With"),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: DropdownButton(
                                  underline: SizedBox.shrink(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  iconSize: 23,

                                  items: _dropdownValues
                                      .map((value) => DropdownMenuItem(
                                            child: Text(value),
                                            value: value,
                                          ))
                                      .toList(),
                                  //   onChanged: (String value) {},
                                  isExpanded: true,
                                  value: _dropdownValues.first,
                                  onChanged: (String? value) {},
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Note"),
                              SizedBox(
                                height: 5,
                              ),
                              TextFieldDelivery(
                                maxLine: 6,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 85,
                      width: double.infinity,
                      color: AppColors.deliveryPrimary,
                      child: Center(
                          child: Text(
                        "Transfer Amount",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
