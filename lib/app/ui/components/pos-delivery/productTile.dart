import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';

class DeliveyProductTile extends StatelessWidget {
  const DeliveyProductTile({
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
            // controller.actionOnRemoveItemList(cInfo);
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
            Text(
              "Bar Soap",
              style: CustomTextStyle.mainTitle
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              "Rs 2240",
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
              "Price : 20 | Qty : 100 | Gst : 240",
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
