import 'package:flutter/cupertino.dart';

enum screenName {
  products,
  cart,
  orderHistory,
  account,
  settings,
}

class ScreenProvider extends ChangeNotifier {
  int index = 0;

  void changeScreen(screenName val) {
    index = val.index;
    notifyListeners();
  }

  String get name {
    if (index == 0) {
      return 'Restaurancja';
    } else if (index == 1) {
      return 'Koszyk';
    } else if (index == 2) {
      return 'Historia zamówień';
    } else if (index == 3) {
      return 'Konto';
    } else if (index == 4) {
      return 'Ustawienia';
    } else {
      return 'Restaurancja';
    }
  }
}
