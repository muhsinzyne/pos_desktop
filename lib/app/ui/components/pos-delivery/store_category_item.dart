import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class StoreCategoryItem extends StatelessWidget {
  final String text;
  final IconData icon;
  const StoreCategoryItem({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // height: 10,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.newPrimary,
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
