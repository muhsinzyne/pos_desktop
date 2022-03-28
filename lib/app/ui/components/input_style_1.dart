import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:posdelivery/app/locator.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

import '../../locator.dart';

class UserInputStyle1 extends StatelessWidget {
  final Color mainColor;
  final Color secondColor;
  final TextEditingController inputCtl;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final String labelKey;
  final IconData? icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final bool hidePassword;
  final Function() passwordToggle;
  final FormFieldValidator<String>? validator;
  final bool invalidBorder;
  final AutovalidateMode autovalidateMode;
  const UserInputStyle1({
    Key? key,
    this.mainColor = AppColors.primary,
    required this.inputCtl,
    this.focusNode,
    this.onFieldSubmitted,
    this.labelKey = 'app_title',
    this.icon,
    this.secondColor = AppColors.primaryVariant,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
    this.hidePassword = false,
    this.passwordToggle = dummyFunction,
    this.validator,
    this.invalidBorder = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: invalidBorder ? Colors.red : mainColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        obscureText:
            (isPassword == true && hidePassword == true) ? true : false,
        controller: inputCtl,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelKey.tr,
          labelStyle: TextStyle(color: mainColor),
          icon: Icon(
            icon,
            color: secondColor,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    hidePassword == true
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                  ),
                  onPressed: passwordToggle,
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
