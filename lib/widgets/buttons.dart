import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/models/category.dart';

class CategoryButton extends StatelessWidget {
  final Category category;
  final VoidCallback onClick;

  const CategoryButton(
      {Key? key, required this.category, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle;
    final TextStyle textStyle;

    if (category.isActive) {
      buttonStyle = ElevatedButton.styleFrom(
        primary: greenColor,
      );
      textStyle = const TextStyle(color: Colors.white);
    } else {
      buttonStyle = ElevatedButton.styleFrom(
        primary: Colors.white,
      );
      textStyle = const TextStyle(color: primaryColor);
    }

    return ElevatedButton(
      onPressed: onClick,
      style: buttonStyle,
      child: Text(
        category.name,
        style: textStyle,
      ),
    );
  }
}
