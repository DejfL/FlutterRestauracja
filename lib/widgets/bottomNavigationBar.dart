import 'package:flutter/material.dart';
import 'package:restauracja/const.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int index;
  final Function(int) onItemTapped;

  const MyBottomNavigationBar({
    Key? key,
    required this.index,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onItemTapped,
      elevation: 5,
      selectedItemColor: greenColor,
      unselectedItemColor: primaryColor.withOpacity(0.5),
      iconSize: 30,
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Column(
            children: [
              const Icon(
                Icons.home,
              ),
              SizedBox(
                width: 20,
                height: 5,
                child: index == 0
                    ? const Divider(
                        color: greenColor,
                        thickness: 4,
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              const Icon(
                Icons.shopping_cart,
              ),
              SizedBox(
                width: 20,
                height: 5,
                child: index == 1
                    ? const Divider(
                        color: greenColor,
                        thickness: 4,
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              const Icon(
                Icons.list,
              ),
              SizedBox(
                width: 20,
                height: 5,
                child: index == 2
                    ? const Divider(
                        color: greenColor,
                        thickness: 4,
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              const Icon(
                Icons.person,
              ),
              SizedBox(
                width: 20,
                height: 5,
                child: index == 3
                    ? const Divider(
                        color: greenColor,
                        thickness: 4,
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
          label: '',
        ),
      ],
    );
  }
}
