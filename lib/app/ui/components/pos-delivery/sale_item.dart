import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posdelivery/app/modules/product_list/bindings/product_list_binding.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/pos/product.dart';

class SaleItem extends StatelessWidget {
  final Product product;
  final int index;
  final Function(Product) addToBasket;
  const SaleItem({
    Key? key,
    required this.addToBasket,
    required this.product,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.screenWidth * 0.38,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffEBEBEB)),
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
                    elevation: 3,
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
                    Expanded(
                      flex: 1,
                      child: Text(
                        product.label!,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        product.row!.price.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: InkWell(
                          onTap: () {
                            addToBasket(product);
                          },
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
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                )),
          ]),
          double.parse(product.row?.discount ?? "0") > 0
              ? Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 20,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Text(
                      product.row?.discount! ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
