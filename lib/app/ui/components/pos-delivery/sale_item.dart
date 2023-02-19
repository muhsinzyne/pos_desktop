import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/models/constants.dart';

class SaleItem extends StatelessWidget {
  const SaleItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.screenWidth * 0.38,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
        color: AppColors.newBg,
      ),
      child: Stack(
        children: [
          Column(children: [
            Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 20,
                    right: 10,
                  ),
                  child: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )),
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Dawny Valley Dew 100 ml Valley",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "22 SAR",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          // width: 85,
                          decoration: BoxDecoration(
                              color: AppColors.newIconColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                              child: Text(
                            "Add to Basket",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                )),
          ]),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 20,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                "20%",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}