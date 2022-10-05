import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/providers/screenProvider.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenProvider = context.watch<ScreenProvider>();

    return BottomNavigationBar(
      onTap: (val) {
        Provider.of<ScreenProvider>(context, listen: false).changeScreen(val);
      },
      elevation: 5,
      selectedItemColor: greenColor,
      unselectedItemColor: primaryColor.withOpacity(0.5),
      iconSize: 30,
      type: BottomNavigationBarType.fixed,
      currentIndex: screenProvider.index,
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
                child: screenProvider.index == 0
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
                child: screenProvider.index == 1
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
                child: screenProvider.index == 2
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
                child: screenProvider.index == 3
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
                Icons.settings,
              ),
              SizedBox(
                width: 20,
                height: 5,
                child: screenProvider.index == 4
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
