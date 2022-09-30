import 'package:flutter/material.dart';
import '../const.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final IconData? iconData;
  final Function(String val)? onChanged;

  const MyTextFormField(
    this.hintText, {
    this.iconData,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      style: TextStyle(color: primaryColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: primaryColor.withOpacity(0.5)),
        prefixIcon: iconData != null
            ? Icon(
                iconData,
                color: primaryColor.withOpacity(0.5),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
