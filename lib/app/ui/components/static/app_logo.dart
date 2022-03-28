import 'package:flutter/material.dart';
import 'package:posdelivery/models/constants.dart';

class AppLogo extends StatelessWidget {
  final bool inverse;
  const AppLogo({
    Key? key,
    this.inverse = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        inverse ? Constants.appLogoInvertPath : Constants.appLogoPath,
      ),
    );
  }
}
