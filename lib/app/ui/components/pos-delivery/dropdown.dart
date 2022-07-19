import 'package:flutter/material.dart';

class DropdownDelivey extends StatelessWidget {
  const DropdownDelivey({
    Key? key,
    required List<String> dropdownValues,
  })  : _dropdownValues = dropdownValues,
        super(key: key);

  final List<String> _dropdownValues;

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      //     margin: EdgeInsets.only(right: 30),
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15.0),
        // border: Border.all(
        // color: Colors.red,
        // style: BorderStyle.solid,
        // width: 0.10),
      ),
      child: DropdownButton(
        underline: SizedBox.shrink(),
        style: TextStyle(
          fontSize: 13,
          color: Colors.black,
        ),
        iconSize: 23,
        items: _dropdownValues
            .map((value) => DropdownMenuItem(
                  child: Text(value),
                  value: value,
                ))
            .toList(),
        //   onChanged: (String value) {},
        isExpanded: false,
        value: _dropdownValues.first,
        onChanged: (String? value) {},
      ),
    );
  }
}
