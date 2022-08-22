import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/delivery/requests/cart_product.dart';

class DeliveyProductTile extends StatelessWidget {
  final int id;
  final CartProduct item;
  final String productName;
  final String price;
  final String qty;
  final String tax;
  final String totalPrice;
  final Function(int, CartProduct) delete;
  const DeliveyProductTile({
    required this.productName,
    required this.price,
    required this.qty,
    required this.tax,
    required this.totalPrice,
    required this.delete,
    required this.id,
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionExtentRatio: .25,
      // showAllActionsThreshold: ,
      secondaryActions: [
        IconSlideAction(
          caption: 'edit',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: () {
            // controller.actionOnEditRequest(cInfo);
          },
          closeOnTap: true,
        ),
        IconSlideAction(
          caption: 'delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            delete(id, item);
          },
          closeOnTap: true,
        ),
      ],
      actionPane: SlidableDrawerActionPane(),
      child: Column(children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                productName,
                maxLines: 3,
                style: CustomTextStyle.mainTitle
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              totalPrice,
              style: CustomTextStyle.mainTitle
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              "Price : $price | Qty : $qty | Tax : $tax",
              style: CustomTextStyle.mainTitle.copyWith(
                  fontSize: 15,
                  color: Color(0xff5E6164),
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Divider(
          thickness: 2,
        ),
      ]),
    );
  }
}
