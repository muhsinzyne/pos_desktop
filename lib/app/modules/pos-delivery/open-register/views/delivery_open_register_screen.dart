// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/dropdown.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';

import '../../../../../models/constants.dart';

class DeliveryOpenRegisterScreen extends StatelessWidget {
  DeliveryOpenRegisterScreen({Key? key}) : super(key: key);
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Open",
                            style: CustomTextStyle.mainTitle,
                          ),
                          Text(
                            "Register",
                            style: CustomTextStyle.mainTitle,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Previous Balance/cash in Hand"),
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
                              Text("New Amount"),
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
                              Text("Payment Mode"),
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
                              Text("Recieved From"),
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
                        "Open Register",
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
