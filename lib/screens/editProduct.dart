

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

class EditProduct extends StatefulWidget {
  //EditProduct({Key? key}) : super(key:key);
  final String productID;
  final String image;
  final String name;
  final String description;
  final String packing;
  final double price;
  final int quantity;
  final String categoryID;
  EditProduct(
    {required this.productID,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.image,
    required this.categoryID,
    required this.packing}
  );

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

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
        title: Text("Edit Product", style: TextStyle(color: Colors.black)),
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
                              productController.editProduct.update(
                                'image', (_) => image, 
                                ifAbsent: () => image
                              );
                              print(productController.editProduct['image']);
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
                            fontSize: 15,
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
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextFormField(
                  widget.name,
                  'Product Name',
                  'name',
                  productController,
                ),
                _buildTextFormField(
                  widget.description,
                  'Product Description',
                  'description',
                  productController,
                ),
                _buildNumberFormField(
                  widget.price.toString(),
                  'Product Price',
                  'price',
                  productController,
                ),
                _buildNumberFormField(
                  widget.quantity.toString(),
                  'Product Quantity',
                  'quantity',
                  productController,
                ),
                _buildTextFormField(
                  widget.packing,
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
                      hint: Text("Product Category", style: TextStyle(fontSize: 15)),
                      items: categories.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() { 
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
                      "Update Product",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if(productController.editProduct['name']==null){
                        productController.editProduct.update(
                          'name',
                          (_) => widget.name,
                          ifAbsent: () => widget.name,
                        );
                      }
                      if(productController.editProduct['description']==null){
                        productController.editProduct.update(
                          'description',
                          (_) => widget.description,
                          ifAbsent: () => widget.description,
                        );
                      }
                      if(productController.editProduct['price']==null){
                        productController.editProduct.update(
                          'price',
                          (_) => widget.price.toString(),
                          ifAbsent: () => widget.price.toString(),
                        );
                      }
                      if(productController.editProduct['quantity']==null){
                        productController.editProduct.update(
                          'quantity',
                          (_) => widget.quantity.toString(),
                          ifAbsent: () => widget.quantity.toString(),
                        );
                      }
                      if(productController.editProduct['packing']==null){
                        productController.editProduct.update(
                          'packing',
                          (_) => widget.packing,
                          ifAbsent: () => widget.packing,
                        );
                      }
                      if(productController.editProduct['image']==null){
                        productController.editProduct.update(
                          'image',
                          (_) => widget.image,
                          ifAbsent: () => widget.image,
                        );
                      }
                      if(productController.editProduct['categoryID']==null){
                        productController.editProduct.update(
                          'categoryID',
                          (_) => widget.categoryID,
                          ifAbsent: () => widget.categoryID,
                        );
                      }
                      database.editProduct(Product(
                        name: productController.editProduct['name'], 
                        description: productController.editProduct['description'], 
                        price: double.parse(productController.editProduct['price']), 
                        quantity: int.parse(productController.editProduct['quantity']), 
                        image: productController.editProduct['image'], 
                        categoryID: productController.editProduct['categoryID'], 
                        packing: productController.editProduct['packing'], 
                      ), widget.productID);
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
      style: TextStyle(fontSize: 15),
    )
  );

  TextFormField _buildTextFormField(
    String hintText, 
    String labelText,
    String name,
    ProductController productController,
    ) {
    return TextFormField(
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 15),
        hintText: hintText,
        labelText: labelText
      ),
      onChanged: (value) {
        productController.editProduct.update(
          name,
          (_) => value,
          ifAbsent: () => value,
        );
      },
    );
  }

    TextFormField _buildNumberFormField(
    String hintText, 
    String labelText,
    String name,
    ProductController productController,
    ) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
      ],
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 15),
        hintText: hintText,
        labelText: labelText
      ),
      onChanged: (value) {
        productController.editProduct.update(
          name,
          (_) => value,
          ifAbsent: () => value,
        );
      },
    );
  }
}