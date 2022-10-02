import 'package:flutter/material.dart';
import '../const.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? textEditingController;
  final IconData? iconData;
  final String? initialValue;
  final bool isReadOnly;
  final int lines;
  final Function(String val)? onChanged;

  const MyTextFormField({
    this.hintText,
    this.textEditingController,
    this.iconData,
    this.initialValue,
    this.isReadOnly = false,
    this.lines = 1,
    this.onChanged,
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
      onChanged: onChanged,
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
    );
  }
}
