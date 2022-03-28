import 'package:flutter/material.dart';
import 'package:posdelivery/controllers/app_controller.dart';

class AppVersionRow extends StatelessWidget {
  const AppVersionRow({
    Key? key,
    required this.appController,
  }) : super(key: key);

  final AppController appController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            appController.appVersion,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
