import 'package:flutter/material.dart';
import 'package:e_bajrai_mini_market/model/product.dart';
import 'package:e_bajrai_mini_market/provider/product_provider.dart';
import 'package:e_bajrai_mini_market/widgets/singleproduct.dart';
//import 'package:provider/provider.dart';

class SearchProduct extends SearchDelegate<void> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ProductProvider providerProvider = Provider.of(context);
    List<Product> searchProduct = providerProvider.searchProductList(query);

    return GridView.count(
      childAspectRatio: 0.87,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: providerProvider
          .map((e) => SingleProduct(
                image: e.image,
                name: e.name,
                price: e.price,
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProductProvider providerProvider = Provider.of(context);
    List<Product> searchProduct = providerProvider.searchProductList(query);

    return GridView.count(
      childAspectRatio: 0.67,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchProduct
          .map((e) => SingleProduct(
                image: e.image,
                name: e.name,
                price: e.price,
              ))
          .toList(),
    );
  }
}
