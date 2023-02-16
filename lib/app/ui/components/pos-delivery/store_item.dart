import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/app/ui/theme/delivery_textStyle.dart';

class StoreItem extends StatelessWidget {
  const StoreItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: AppColors.newBlue,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Store 1",
                            style: CustomTextStyle.common.copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              "4.2 km Away ",
                              style: CustomTextStyle.common.copyWith(
                                fontSize: 12,
                                color: Color(0xff8D9EA4),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            child: Flexible(
                              child: Text(
                                "Julmudah, AlJubail 35671, Saudia Arabia  ",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyle.common.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 28,
                  color: Color(0xff454E52),
                ),
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
