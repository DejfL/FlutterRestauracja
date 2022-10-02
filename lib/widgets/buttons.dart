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
    final Color buttonColor;
    final TextStyle textStyle;

    if (category.isActive) {
      buttonColor = greenColor;
      textStyle = const TextStyle(color: Colors.white);
    } else {
      buttonColor = Colors.white;
      textStyle = const TextStyle(color: primaryColor);
    }

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      primary: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

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

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const PrimaryButton({Key? key, required this.text, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            primary: greenColor,
            elevation: 4,
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class AddReduceButton extends StatelessWidget {
  final VoidCallback onClick;
  final IconData icon;
  final bool isEnabled;

  const AddReduceButton.add({
    Key? key,
    required this.onClick,
    this.isEnabled = true,
  })  : icon = Icons.add,
        super(key: key);

  const AddReduceButton.reduce({
    Key? key,
    required this.onClick,
    this.isEnabled = true,
  })  : icon = Icons.remove,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 45,
      child: ElevatedButton(
        onPressed: isEnabled ? onClick : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
          primary: greenColor,
          elevation: 4,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 40,
          ),
        ),
      ),
    );
  }
}
