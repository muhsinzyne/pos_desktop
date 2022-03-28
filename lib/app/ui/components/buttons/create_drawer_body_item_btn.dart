import 'package:flutter/material.dart';

import '../../../locator.dart';

class DrawerBodyItemButton extends StatelessWidget {
  final String? text;
  final Icon? icon;
  final GestureTapCallback? onTap;
  const DrawerBodyItemButton({Key? key, this.icon, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap ?? dummyFunction,
      title: Row(
        children: <Widget>[
          icon ?? Icon(Icons.mic),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text ?? ''),
          )
        ],
      ),
    );
  }
}
