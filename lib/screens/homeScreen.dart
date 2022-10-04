import 'package:flutter/material.dart';
import 'package:restauracja/screens/accountScreen.dart';
import 'package:restauracja/screens/cartScreen.dart';
import 'package:restauracja/screens/orderHistoryScreen.dart';
import 'package:restauracja/screens/productsScreen.dart';
import 'package:restauracja/widgets/appBar.dart';
import 'package:restauracja/widgets/bottomNavigationBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Widget> _screens = [
    ProductsScreen(),
    CartScreen(),
    OrderHistoryScreen(),
    AccountScreen(),
  ];

  int _indexScreen = 0;

  void _onItemTapped(int index) {
    setState(() {
      _indexScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(indexScreen: _indexScreen),
      body: _screens[_indexScreen],
      bottomNavigationBar: MyBottomNavigationBar(
        index: _indexScreen,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
