

import 'package:e_bajrai_mini_market/controller/product_controller.dart';
import 'package:e_bajrai_mini_market/model/product.dart';
import 'package:e_bajrai_mini_market/services/databaseService.dart';
import 'package:e_bajrai_mini_market/screens/homepageAdmin.dart';
import 'package:e_bajrai_mini_market/services/storageService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key:key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final controller = Get.put(ProductController());

  final ProductController productController = Get.find();

  StorageService storage = StorageService();

  DatabaseService database = DatabaseService();

  final categories = ['Fruit and Vegetables', 'Dairy and Eggs', 'Meat and Fish', 'Beverages'];

  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Product", style: TextStyle(color: Colors.black)),
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
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: HexColor("#79ad8c"),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            ImagePicker _picker = ImagePicker();
                            final XFile? _image = await _picker.pickImage(
                              source: ImageSource.gallery);
          
                            if (_image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No image was selected'),
                                ),
                              );
                            }
          
                            if(_image != null) {
                              await storage.uploadImage(_image);
                              var image = await storage.getDownloadURL(_image.name);
                              productController.newProduct.update(
                                'image', (_) => image, 
                                ifAbsent: () => image
                              );
                              print(productController.newProduct['image']);
                            }
                          }, 
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                        ), 
                        const Text(
                          "Add Image",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Product Information",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextFormField(
                  'Product Name',
                  'name',
                  productController,
                ),
                _buildTextFormField(
                  'Product Description',
                  'description',
                  productController,
                ),
                _buildNumberFormField(
                  'Product Price',
                  'price',
                  productController,
                ),
                _buildNumberFormField(
                  'Product Quantity',
                  'quantity',
                  productController,
                ),
                _buildTextFormField(
                  'Product Packing Size',
                  'packing',
                  productController,
                ),
                Container(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: value,
                      iconSize: 36,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      isExpanded: true,
                      hint: Text("Product Category"),
                      items: categories.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() { 
                        // if(value=="Fruit and Vegetables") {this.value = "fruitVeg";}
                        // else if(value=="Dairy and Eggs") {this.value = "dairyEgg";}
                        // else if(value=="Meat and Fish") {this.value = "meatFish";}
                        // else if(value=="Beverages") {this.value = "beverage";}
                        this.value = value;
                        productController.newProduct.update(
                          'categoryID',
                          (_) => value,
                          ifAbsent: () => value,
                        );
                      },)
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  height: 60,
                  width: 165,
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
                      "Add Product",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      database.addProduct(Product(
                        name: productController.newProduct['name'], 
                        description: productController.newProduct['description'], 
                        price: double.parse(productController.newProduct['price']), 
                        quantity: int.parse(productController.newProduct['quantity']), 
                        image: productController.newProduct['image'], 
                        categoryID: productController.newProduct['categoryID'], 
                        packing: productController.newProduct['packing'], 
                      ));
                    },
                  )
                ),
                SizedBox(height: 10),
              ],
            ), 
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(fontSize: 17),
    )
  );

  TextFormField _buildTextFormField(
    String hintText, 
    String name,
    ProductController productController,
    ) {
    return TextFormField(
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 17),
        hintText: hintText
      ),
      onChanged: (value) {
        productController.newProduct.update(
          name,
          (_) => value,
          ifAbsent: () => value,
        );
      },
    );
  }

    TextFormField _buildNumberFormField(
    String hintText, 
    String name,
    ProductController productController,
    ) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
      ],
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 17),
        hintText: hintText
      ),
      onChanged: (value) {
        productController.newProduct.update(
          name,
          (_) => value,
          ifAbsent: () => value,
        );
      },
    );
  }
}