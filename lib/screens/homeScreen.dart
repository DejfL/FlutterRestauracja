import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restauracja/const.dart';
import 'package:restauracja/dummyData.dart';
import 'package:restauracja/helpers/screenState.dart';
import 'package:restauracja/models/product.dart';
import 'package:restauracja/screens/productScreen.dart';
import 'package:restauracja/widgets/appBar.dart';
import 'package:restauracja/widgets/bottomNavigationBar.dart';
import 'package:restauracja/widgets/buttons.dart';
import 'package:restauracja/widgets/somethingWentWrong.dart';
import 'package:restauracja/widgets/textFormField.dart';
import '../providers/productsProvider.dart';
import 'package:restauracja/models/category.dart' as category;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
      ],
      builder: (context, _) {
        void searchProduct(String val) {
          Provider.of<ProductsProvider>(context, listen: false).searchText =
              val;
        }

        return Scaffold(
          appBar: const MyAppBar('Restaurancja'),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextFormField(
                  hintText: 'Wyszukaj...',
                  iconData: Icons.search,
                  onChanged: searchProduct,
                ),
              ),
              const CategoriesAndProduct(),
            ],
          ),
          bottomNavigationBar: const MyBottomNavigationBar(),
        );
      },
    );
  }
}

class CategoriesAndProduct extends StatelessWidget {
  const CategoriesAndProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductsProvider>();

    if (productProvider.screenState == ScreenState.Loading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (productProvider.screenState == ScreenState.Error) {
      return const SomethingWentWrong();
    }

    return Expanded(
      child: Column(
        children: const [
          Categories(),
          Products(),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductsProvider>();

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productProvider.categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: CategoryButton(
              category: productProvider.categories[index],
              onClick: () {
                _selectCategory(context, productProvider.categories[index]);
              },
            ),
          );
        },
      ),
    );
  }

  void _selectCategory(BuildContext context, category.Category category) {
    Provider.of<ProductsProvider>(context, listen: false).selectedCategory =
        category;
  }
}

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductsProvider>();
    final List<Product> products = productProvider.products();

    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.9,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(
            product: products[index],
          );
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Hero(
        tag: product.id,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(product: product),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: const [
                BoxShadow(
                  color: primaryColor,
                  blurRadius: 5,
                  offset: Offset(0.0, -1),
                )
              ],
              color: Colors.black.withOpacity(1),
              image: DecorationImage(
                image: NetworkImage(
                  product.imageSrc,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Colors.black.withOpacity(0.6)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          product.name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Text(
                        '${product.price.toStringAsFixed(2)} zł',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
