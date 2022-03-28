import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ItemSummaryTile extends StatelessWidget {
  final String label;
  final String value;

  const ItemSummaryTile({
    Key? key,
    this.label = '',
    this.value = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}

class ItemsListTile extends StatelessWidget {
  final String number;
  final String itemName;
  final String qty;
  final String unitPrice;
  final String taxAmount;
  final String subTotal;

  const ItemsListTile({
    Key? key,
    this.number = '',
    this.itemName = '',
    this.qty = '',
    this.unitPrice = '',
    this.taxAmount = '',
    this.subTotal = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Text(number),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: AutoSizeText(
                  itemName,
                  maxLines: 3,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: AutoSizeText(
                  qty,
                  maxLines: 3,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: AutoSizeText(
                  unitPrice,
                  maxLines: 3,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: AutoSizeText(
                  taxAmount,
                  maxLines: 3,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: AutoSizeText(
                  subTotal,
                  maxLines: 3,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
