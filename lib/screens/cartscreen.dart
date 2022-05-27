import 'package:e_bajrai_mini_market/screens/card_products.dart';
import 'package:e_bajrai_mini_market/screens/cart_total.dart';
import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:e_bajrai_mini_market/widgets/cartsingleproduct.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './checkout.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:e_bajrai_mini_market/controller/cart_controller.dart';
import 'package:hexcolor/hexcolor.dart';

// class CartScreen extends StatefulWidget {
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }

// late ProductProvider productProvider;

// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     productProvider = Provider.of<ProductProvider>(context);
//     return Scaffold(
//       bottomNavigationBar: Container(
//         height: 70,
//         width: 100,
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         padding: EdgeInsets.only(bottom: 15),
//         child: ElevatedButton(
//           style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff746bc9))),
//           child: Text(
//             "Continous",
//             style: TextStyle(fontSize: 18, color: Colors.white),
//           ),
//           onPressed: () {
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (ctx) => CheckOut(
//                       // image: widget.image,
//                       // name: widget.name,
//                       // price: widget.price,
//                     )));
//           },
//         ), //RaisedButton
//       ),
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Cart Page",
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         leading: IconButton(
//           onPressed: () {},
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.notifications_none,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: productProvider.getCartModelListLength,
//         itemBuilder: (ctx, index) => CartSingleProduct(
//           image: productProvider.getCartModelList[index].image,
//           name: productProvider.getCartModelList[index].name,
//           price: productProvider.getCartModelList[index].price,
//           quantity: productProvider.getCartModelList[index].quantity,
//         ),
//       ),
//     );
//   }
// }

class CartScreen extends StatelessWidget {
  final cartController = Get.put(CartController());
  final controller = Get.find<CartController>();
  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Your Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => HomePage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          CartProducts(),
          Divider(
            color: HexColor("#cccccc"),
            height: 25,
            thickness: 3,
            indent: 5,
            endIndent: 5,
          ),
          SizedBox(height: 10),
          CartTotal(),
          SizedBox(height: 20),
          Container(
            height: 60,
            width: 350,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                      HexColor("#53B175"))),
              child: Text(
                "Checkout",
                style: myStyle,
              ),
              onPressed: () {
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (ctx) => ,
                //   ),
                // );
              },
            )
          ),
        ],
      ),
    );
  }
}
