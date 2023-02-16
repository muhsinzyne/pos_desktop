import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/models/constants.dart';

class DashboardItemBox extends StatelessWidget {
  final String title;
  final String icon;
  const DashboardItemBox({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.screenWidth * 0.41,
      // height: 110,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // color: Colors.blueAccent,
              width: Constants.screenWidth / 2.8,
              child: SvgPicture.asset(
                icon,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: Constants.screenWidth / 2.8,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff454E52),
                  ),
                  maxLines: 1,
                )),
          ],
        ),
      ),
    );
  }
}
