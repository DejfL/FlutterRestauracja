import 'package:flutter/cupertino.dart';
import 'package:restauracja/helpers/screenState.dart';
import 'package:restauracja/models/category.dart' as category;
import 'package:restauracja/models/product.dart';
import 'package:restauracja/models/topping.dart';
import '../dummyData.dart' as dummy;

class ProductsProvider extends ChangeNotifier {
  ScreenState screenState = ScreenState.Initial;

  List<Product> _products = [];
  List<category.Category> categories = dummy.categories;

  ProductsProvider() {
    _getProducts();
  }

  Future<void> _getProducts() async {
    screenState = ScreenState.Loading;
    notifyListeners();

    await Future.delayed(
      const Duration(seconds: 1),
    );

    try {
      _products = dummy.products;
      screenState = ScreenState.Loaded;
    } catch (e) {
      screenState = ScreenState.Error;
    } finally {
      notifyListeners();
    }
  }

  String _searchText = '';
  String get searchText => _searchText;
  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  category.Category _selectedCategory =
      dummy.categories.firstWhere((element) => element.isActive);
  category.Category get selectedCategory => _selectedCategory;
  set selectedCategory(category.Category value) {
    categories.firstWhere((element) => element.isActive).isActive = false;
    categories.firstWhere((element) => element.id == value.id).isActive = true;
    _selectedCategory = value;
    notifyListeners();
  }

  List<Product> products() {
    if (_searchText.isNotEmpty && selectedCategory.isNotAll) {
      return _products
          .where(
            (element) =>
                element.name.toLowerCase().contains(
                      _searchText.toLowerCase(),
                    ) &&
                element.category.id == _selectedCategory.id,
          )
          .toList();
    } else if (_searchText.isEmpty && selectedCategory.isNotAll) {
      return _products
          .where(
            (element) => element.category.id == _selectedCategory.id,
          )
          .toList();
    } else if (_searchText.isNotEmpty) {
      return _products
          .where(
            (element) => element.name.toLowerCase().contains(
                  _searchText.toLowerCase(),
                ),
          )
          .toList();
    } else {
      return _products;
    }
  }
}
