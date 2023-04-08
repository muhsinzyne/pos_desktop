import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';

import 'package:expandable/expandable.dart';
import 'package:sizer/sizer.dart';

class SalesListItem extends StatefulWidget {
  final Color statusColor;

  SalesListItem({
    required this.statusColor,
    Key? key,
  }) : super(key: key);

  @override
  State<SalesListItem> createState() => _SalesListItemState();
}

ExpandableController expandableController = ExpandableController();

class _SalesListItemState extends State<SalesListItem> {
  bool isExpanded = false;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ExpandableNotifier(
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            // height: 300,
            width: double.maxFinite,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: ScrollOnExpand(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.statusColor,
                              shape: BoxShape.circle,
                            ),
                            // height: 40,
                            // width: 40,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Store 1",
                                  style: CustomTextStyle.common.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    "Completed",
                                    style: CustomTextStyle.common.copyWith(
                                      fontSize: 12,
                                      color: widget.statusColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "SALE00000058",
                                  maxLines: 3,
                                  overflow: TextOverflow.visible,
                                  style: CustomTextStyle.common.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "6000 SAR",
                                  style: CustomTextStyle.common.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: widget.statusColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  // width: (double.maxFinite) + 8.5.sp5,
                                  child: Text(
                                    "06/09/2022 | 16:55:00",
                                    maxLines: 3,
                                    overflow: TextOverflow.visible,
                                    style: CustomTextStyle.common.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isExpanded = expandableController.value;
                                expandableController.toggle();
                              });
                            },
                            child: isExpanded
                                ? const Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 38,
                                    color: Color(0xff454E52),
                                  )
                                : const Icon(
                                    Icons.keyboard_arrow_up,
                                    size: 38,
                                    color: Color(0xff454E52),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: ExpandablePanel(
                      controller: expandableController,
                      collapsed: Container(),
                      expanded: SaleListItemInvoice(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SaleListItemInvoice extends StatelessWidget {
  SaleListItemInvoice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.newBg,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "TAX INVOICE",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Reference: SALE00000058",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "sl no: SALE 58",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Date: 06/09/2022 16:55",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Sale Status: Completed",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Payment Status : Pending",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Due Date: 0000-00-00",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "No",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8.5.sp,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Description(Code)",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8.5.sp,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Quantity",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8.5.sp,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Unit Price",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8.5.sp,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Tax",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8.5.sp,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Subtotal",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8.5.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 8.5.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "83241537 - green cup",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 8.5.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "1.00 pc",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 8.5.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "SR 25.00",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 8.5.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "SR 3.26",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 8.5.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "SR 25.00",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 8.5.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Total(SR)",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Total Amount(SR)",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Paid(SR)",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Balance(SR)",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Tax Summary",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.newPrimary,
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "Email  ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const Icon(
                      Icons.email,
                      size: 18,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xffC31111),
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    const Text(
                      "Return  ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const Icon(
                      Icons.reply,
                      size: 18,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "PDF",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.newIconColor,
                    ),
                  ),
                  const Icon(
                    Icons.file_download_outlined,
                    size: 28,
                    color: AppColors.newIconColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
