import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/providers/screenProvider.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenProvider = context.watch<ScreenProvider>();

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 1,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (screenProvider.index == 0)
            const Icon(
              Icons.restaurant_menu,
              color: greenColor,
              size: 30,
            ),
          Text(
            screenProvider.name,
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
