import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';

import 'package:expandable/expandable.dart';
import 'package:sizer/sizer.dart';

class SalesListItem extends StatefulWidget {
  final Color statusColor;
  final String refNo;
  final String storeName;
  final String date;
  final String amount;
  final String saleStatus;
  final String id;
  final String paymentStatus;
  final String paid;
  final String balance;
  final Function(String) downloadPdf;
  final String grandTotal;
  SalesListItem(
      {required this.statusColor,
      required this.refNo,
      Key? key,
      required this.storeName,
      required this.date,
      required this.amount,
      required this.saleStatus,
      required this.id,
      required this.paymentStatus,
      required this.paid,
      required this.balance,
      required this.grandTotal,
      required this.downloadPdf})
      : super(key: key);

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
            child: ExpandableNotifier(
              child: ScrollOnExpand(
                child: Column(
                  children: [
                    SizedBox(
                      child: ExpandablePanel(
                        // controller: expandableController,
                        collapsed: ExpandableButton(
                          child: Row(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.storeName,
                                          style: CustomTextStyle.common
                                              .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          child: Text(
                                            widget.saleStatus,
                                            style:
                                                CustomTextStyle.common.copyWith(
                                              fontSize: 12,
                                              color: widget.statusColor,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          widget.refNo,
                                          maxLines: 3,
                                          overflow: TextOverflow.visible,
                                          style:
                                              CustomTextStyle.common.copyWith(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${double.parse(widget.amount).toStringAsFixed(2)} SAR',
                                            overflow: TextOverflow.visible,
                                            style:
                                                CustomTextStyle.common.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: widget.statusColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            widget.date,
                                            maxLines: 3,
                                            overflow: TextOverflow.visible,
                                            style:
                                                CustomTextStyle.common.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        expanded: SaleListItemInvoice(
                          refNum: widget.refNo,
                          saleNum: widget.id,
                          downloadPdf: widget.downloadPdf,
                          balance: widget.balance,
                          paid: widget.paid,
                          grandTotal: widget.grandTotal,
                          date: widget.date,
                          paymentStatus: widget.paymentStatus,
                          status: widget.saleStatus,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SaleListItemInvoice extends StatelessWidget {
  final String refNum;
  final String saleNum;
  final String status;
  final String date;
  final String paymentStatus;
  final String paid;
  final Function(String) downloadPdf;
  final String balance;
  final String grandTotal;
  // final String ;
  SaleListItemInvoice({
    Key? key,
    required this.refNum,
    required this.saleNum,
    required this.status,
    required this.date,
    required this.paymentStatus,
    required this.paid,
    required this.balance,
    required this.grandTotal,
    required this.downloadPdf,
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
            "Reference: $refNum",
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
            "Date: $date",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Sale Status: $status",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Payment Status : $paymentStatus",
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
            "Total(SR): ",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Total Amount(SR): $grandTotal",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Paid(SR): $paid",
            style: TextStyle(
                color: Colors.black,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Balance(SR): $balance",
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
              ExpandableButton(
                child: Container(
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
              ),
              InkWell(
                onTap: () => downloadPdf(saleNum),
                child: Column(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
