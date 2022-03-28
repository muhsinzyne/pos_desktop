import 'package:flutter/material.dart';
import 'package:posdelivery/app/ui/components/static/app_logo.dart';
import 'package:posdelivery/models/constants.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Hero(
                tag: Constants.logoHeroTag,
                child: AppLogo(
                  inverse: true,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
