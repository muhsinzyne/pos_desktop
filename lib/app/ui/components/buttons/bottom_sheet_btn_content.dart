import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetBtnBlock extends StatelessWidget {
  const BottomSheetBtnBlock({
    Key? key,
    this.children,
  }) : super(key: key);

  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      height: Get.height * .08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children ?? [],
      ),
    );
  }
}
