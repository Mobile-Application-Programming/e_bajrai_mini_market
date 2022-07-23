import 'package:e_bajrai_mini_market/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartTotal extends StatelessWidget {
  final cartController = Get.put(CartController());
  final CartController controller = Get.find();
  CartTotal({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>  Container(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold, 
              ),
            ),
            Text(
              '\RM${cartController.totalCartPrice.value.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}