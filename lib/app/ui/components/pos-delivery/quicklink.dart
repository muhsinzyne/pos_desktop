import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuickLink extends StatelessWidget {
  IconData? iconData;
  final double iconSize;
  final String title;
  QuickLink({
    Key? key,
    this.iconData,
    required this.title,
    this.iconSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            if (iconData == null) ...[
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xff8CDF4B),
                    borderRadius: BorderRadius.circular(6)),
              ),
            ] else ...[
              Container(
                child: FaIcon(
                  iconData,
                  size: iconSize,
                  color: Color(0xff4911C3),
                ),
              )
            ],
            SizedBox(
              width: 8,
            ),
            Text(title),
          ]),
          Container(child: Icon(Icons.arrow_right_outlined))
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Divider(
        thickness: 1,
        color: Colors.black26,
      ),
      SizedBox(
        height: 10,
      ),
    ]);
  }
}
