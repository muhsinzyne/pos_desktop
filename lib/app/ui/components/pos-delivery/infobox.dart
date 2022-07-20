import 'package:flutter/material.dart';
import 'package:posdelivery/models/constants.dart';

class InfoBox extends StatelessWidget {
  final String title;
  final String value;
  final Color boxColor;
  const InfoBox({
    Key? key,
    required this.title,
    required this.value,
    required this.boxColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.screenWidth / 2.38,
      height: Constants.screenHeight / 7,
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // color: Colors.blueAccent,
            width: Constants.screenWidth / 2.8,
            child: Text(
              value,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
              width: Constants.screenWidth / 2.8,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                maxLines: 1,
              )),
        ],
      ),
    );
  }
}
