import 'package:flutter/material.dart';
import 'package:restauracja/const.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: greenColor,
      unselectedItemColor: primaryColor.withOpacity(0.5),
      iconSize: 30,
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: '',
        ),
      ],
    );
  }
}
