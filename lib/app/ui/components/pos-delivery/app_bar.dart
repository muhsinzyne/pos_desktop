import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:get/get.dart';
class DeliveryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  const DeliveryAppBar({
    Key? key,
    required this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        InkWell(
          onTap:()=>Get.toNamed(Routes.newProfile),
          child: Container(
            padding: const EdgeInsets.only(
              right: 30,
            ),
            child: SvgPicture.asset(
              "assets/svg/profile.svg",
              height: 30,
              width: 30,
            ),
          ),
        ),
      ],
      leading: Container(
        padding: const EdgeInsets.only(
          left: 30,
        ),
        child: Icon(
          Icons.notifications_active,
          color: AppColors.newIconColor,
          size: 30,
        ),
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
