import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauracja/providers/screenProvider.dart';
import 'package:restauracja/screens/accountScreen.dart';
import 'package:restauracja/screens/cartScreen.dart';
import 'package:restauracja/screens/orderHistoryScreen.dart';
import 'package:restauracja/screens/productsScreen.dart';
import 'package:restauracja/screens/settingsScreen.dart';
import 'package:restauracja/widgets/appBar.dart';
import 'package:restauracja/widgets/bottomNavigationBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const List<Widget> _screens = [
    ProductsScreen(),
    CartScreen(),
    OrderHistoryScreen(),
    AccountScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenProvider = context.watch<ScreenProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(),
      body: _screens[screenProvider.index],
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
