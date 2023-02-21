import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/models/constants.dart';

class BasketItem extends StatelessWidget {
  const BasketItem({
    Key? key,
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
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        // flex: 2,
                        child: const Text(
                          "Dawny Valley Dew 100 ml",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                    // flex: 2,
                    child: const Text(
                  "20 SAR",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  // flex: 3,
                  child: Row(
                    children: [
                      Container(
                        // width: 85,
                        decoration: BoxDecoration(
                            color: AppColors.newSecondary,
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                        ),
                        child: const Center(
                            child: Text(
                          "-   1   +",
                          style: TextStyle(
                            color: AppColors.newIconColor,
                          ),
                        )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        // width: 85,
                        decoration: BoxDecoration(
                            color: const Color(0xff9B1F1F),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: const Center(
                            child: Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
