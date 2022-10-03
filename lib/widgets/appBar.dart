import 'package:flutter/material.dart';
import 'package:restauracja/const.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final int indexScreen;

  MyAppBar({
    Key? key,
    required this.indexScreen,
  }) : super(key: key);

  String get title {
    if (indexScreen == 0) {
      return 'Restaurancja';
    } else if (indexScreen == 1) {
      return 'Koszyk';
    } else {
      return 'Restaurancja';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Theme.of(context).canvasColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (indexScreen == 0)
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
