import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_bajrai_mini_market/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductController extends GetxController {

  final products = <Product>[].obs;
  var newProduct = {}.obs;
  var editProduct = {}.obs;

  void updateProductPrice(int index, Product product, double value) {
    product.price = value;
    products[index] = product;
  }

  void updateProductQuantity(int index, Product product, int value) {
    product.quantity = value;
    products[index] = product;
  }

  void deleteProduct(String productID){
    final docProduct = FirebaseFirestore.instance.collection('products').doc('$productID');
    docProduct.delete();

    Get.snackbar(
      "Product Deleted", 
      "You have deleted the product from the system",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds:2),
      backgroundColor: HexColor("#2f3330"),
      colorText: HexColor("#fafafa"),
    );
  }

  @override
  void onInit() {
    products.bindStream(getAllProducts());
    super.onInit();
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore
      .collection('products')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
      });
  }
}