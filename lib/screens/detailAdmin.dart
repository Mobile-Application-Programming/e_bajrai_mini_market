import 'package:e_bajrai_mini_market/controller/user_controller.dart';
import 'package:e_bajrai_mini_market/model/cartmodel.dart';
import 'package:e_bajrai_mini_market/model/usermodel.dart';
import 'package:e_bajrai_mini_market/screens/editProduct.dart';
import 'package:e_bajrai_mini_market/screens/homepageAdmin.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:e_bajrai_mini_market/controller/cart_controller.dart';
import 'package:e_bajrai_mini_market/controller/product_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/model/product.dart';

class DetailAdmin extends StatefulWidget {
  final String image;
  final String name;
  final String description;
  final String packing;
  final double price;
  final int quantity;
  final String categoryID;
  DetailAdmin(
      {required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.image,
      required this.categoryID,
      required this.packing});
  @override
  State<DetailAdmin> createState() => _DetailAdminState();
}

class _DetailAdminState extends State<DetailAdmin> {

  int count = 1;
  late int index;
  final cartController = Get.put(CartController());
  final productController = Get.put(ProductController());
  final userController1 = Get.put(UserController());
  UserController userController = UserController.instance;
  final ProductController productController1 = Get.find();
  late String productID;
  
  get console => null;
   
  //late ProductProvider productProvider;
  Widget _buildSizeProduct({required String name}) {
    return Container(
      height: 60,
      width: 60,
      color: Color(0xfff2f2f2),
      child: Center(
          child: Text(
        name,
        style: TextStyle(
          fontSize: 17,
        ),
      )),
    );
  }

  List<Product> productList1=[];
  late Product productData1;
  late Product productBetul;
  late final CartModel cartItem;
  late UserModel user1;
  List<UserModel> userList1=[];

  void productList() async {

      final productData = FirebaseFirestore.instance.collection('products');
      final QuerySnapshot result = await productData.get();

      result.docs.forEach((res) async {
        productData1 = Product( 
          name: res["name"],
          description: res["description"],
          price: res["price"],
          quantity: res["quantity"],
          image: res["image"],
          categoryID: res["categoryID"],
          packing: res["packing"],
        );
        productList1.add(productData1);
        //console.log('${res.id} => ${res.data()}');
        if (res["name"]==widget.name) {
          productID = res.id;
        }
      });
      index = productList1.indexWhere((element) => element.name == widget.name);
  }

  final TextStyle myStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    //productProvider = Provider.of<ProductProvider>(context);
    //productController.getAllProducts();
    productList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail Page", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => HomepageAdmin()),
            );
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 350,
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(13),
                        child: Container(
                          height: 260,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(widget.image),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 150,
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.name,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\RM ${widget.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 85, 94, 88),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 2.0,
                                  ),
                                ),
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 3.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110,
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              widget.description,
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Packing Size",
                        style: myStyle,
                      ),
                      Container(
                        height: 80,
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              widget.packing,
                              style: TextStyle(
                                fontSize: 15,
                                height: 2.5,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "Quantity",
                        style: myStyle,
                      ),
                      Container(
                        height: 80,
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              widget.quantity.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                height: 2.5,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "Category",
                        style: myStyle,
                      ),
                      Container(
                        height: 80,
                        child: Wrap(
                          children: <Widget>[
                            if(widget.categoryID == "meatFish")...[
                              Text("Meat and Fish",style: TextStyle(fontSize: 15,height: 2.5)),
                            ]else if(widget.categoryID == "fruitVeg")...[
                              Text("Fruit and Vegetables",style: TextStyle(fontSize: 15,height: 2.5)),
                            ]else if(widget.categoryID == "dairyEgg")...[
                              Text("Dairy and Eggs",style: TextStyle(fontSize: 15,height: 2.5)),
                            ]else...[
                              Text("Beverages",style: TextStyle(fontSize: 15,height: 2.5))
                            ]
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 60,
                              width: 140,
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
                                  "Edit Product",
                                  style: myStyle,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (ctx) => EditProduct(
                                      productID: productID, 
                                      name: widget.name, 
                                      description: widget.description, 
                                      price: widget.price, 
                                      quantity: widget.quantity,
                                      packing: widget.packing, 
                                      categoryID: widget.categoryID,
                                      image: widget.image
                                    )),
                                  );
                                },
                              )
                          ),
                          Container(width: 10),
                          Container(
                              height: 60,
                              width: 140,
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
                                  "Delete Product",
                                  style: myStyle,
                                ),
                                onPressed: () {
                                  productController1.deleteProduct(productID);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (ctx) => HomepageAdmin()),
                                  );
                                },
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
