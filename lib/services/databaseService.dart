
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/model/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream <List<Product>> getProducts() {
    return _firebaseFirestore.collection("products").snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
      }
    );
  }

  Future<void> addProduct(Product product) {
    Get.snackbar(
      "Product Added", 
      "The product has been successfully added to the system",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds:2),
      backgroundColor: HexColor("#2f3330"),
      colorText: HexColor("#fafafa"),
    );
    return _firebaseFirestore.collection("products").add(product.toMap());


  } 
}