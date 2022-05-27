import 'package:get/get.dart';
import 'package:e_bajrai_mini_market/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductController extends GetxController {

  final products = <Product>[].obs;

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