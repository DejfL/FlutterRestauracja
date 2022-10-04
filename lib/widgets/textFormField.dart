import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../const.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? textEditingController;
  final IconData? iconData;
  final String? initialValue;
  final bool isReadOnly;
  final int lines;
  final bool autoFocus;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Function(String val)? onChanged;
  final Function(String val)? onFieldSubmitted;

  const MyTextFormField({
    this.hintText,
    this.textEditingController,
    this.iconData,
    this.initialValue,
    this.isReadOnly = false,
    this.lines = 1,
    this.autoFocus = false,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.onChanged,
    this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      maxLines: lines,
      initialValue: initialValue,
      readOnly: isReadOnly,
      textAlign: TextAlign.start,
      autofocus: autoFocus,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      style: const TextStyle(color: primaryColor),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 15, top: 15),
        hintText: hintText,
        hintStyle: TextStyle(color: primaryColor.withOpacity(0.5)),
        prefixIcon: iconData != null
            ? Icon(
                iconData,
                color: primaryColor.withOpacity(0.5),
              )
            : null,
      ),
      validator: (val) {
        if (TextInputType.emailAddress == textInputType) {
          if (EmailValidator.validate(val.toString())) {
            return null;
          } else {
            return 'Nieprawidłowy email';
          }
        } else {
          if (val != null && val.toString().isNotEmpty) {
            return null;
          } else {
            return 'Nieprawidłowa wartość';
          }
        }
      },
    );
  }
}
