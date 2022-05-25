import 'package:e_bajrai_mini_market/widgets/cartsingleproduct.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './checkout.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

ProductProvider productProvider;

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 15),
        child: RaisedButton(
          color: Color(0xff746bc9),
          child: Text(
            "Continous",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => CheckOut(
                      image: widget.image,
                      name: widget.name,
                      price: widget.price,
                    )));
          },
        ), //RaisedButton
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart Page",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productProvider.getCartModelListLength,
        itemBuilder: (ctx, index) => CartSingleProduct(
          image: productProvider.getCartModelList[index].image,
          name: productProvider.getCartModelList[index].name,
          price: productProvider.getCartModelList[index].price,
          quantity: productProvider.getCartModelList[index].quantity,
        ),
      ),
    );
  }
}
