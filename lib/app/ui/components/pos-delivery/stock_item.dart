import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:logger/logger.dart';

class StockItem extends StatelessWidget {
  final String label;
  final String price;
  final int qty;
  const StockItem({
    Key? key,
    required this.label,
    required this.price,
    required this.qty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.maxFinite,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffEBEBEB)),
        color: AppColors.newBg,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                  // flex: 2,
                    child: Text(
                      price,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(qty.toString()),
          ),
        ],
      ),
    );
  }
}
