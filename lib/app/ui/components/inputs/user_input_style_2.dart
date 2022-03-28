import 'package:flutter/material.dart';
import 'package:posdelivery/app/locator.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';

class UserInputStyle2 extends StatelessWidget {
  final Color mainColor;
  final Color secondColor;
  final TextEditingController? inputCtl;
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
  final AutovalidateMode autoValidateMode;
  final EdgeInsetsGeometry? padding;
  final double bottomSpacing;
  const UserInputStyle2({
    Key? key,
    this.mainColor = AppColors.primary,
    this.inputCtl,
    this.focusNode,
    this.onFieldSubmitted,
    this.labelKey = '',
    this.icon,
    this.secondColor = AppColors.primaryVariant,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
    this.hidePassword = false,
    this.passwordToggle = dummyFunction,
    this.validator,
    this.invalidBorder = false,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.padding,
    this.bottomSpacing = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (padding != null)
          ? padding
          : EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      margin: EdgeInsets.only(bottom: bottomSpacing),
      child: TextFormField(
        autovalidateMode: autoValidateMode,
        obscureText:
            (isPassword == true && hidePassword == true) ? true : false,
        controller: inputCtl,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelKey,
        ),
      ),
    );
  }
}
