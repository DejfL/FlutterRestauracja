import 'package:flutter/material.dart';
import 'package:restauracja/const.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const MyAppBar(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Theme.of(context).canvasColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.restaurant_menu,
            color: greenColor,
            size: 30,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
