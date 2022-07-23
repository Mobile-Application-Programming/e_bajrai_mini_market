import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/screens/detailscreen.dart';
import 'package:e_bajrai_mini_market/screens/listproduct.dart';
import 'package:flutter/material.dart';
import 'package:e_bajrai_mini_market/model/product.dart';
import 'package:e_bajrai_mini_market/widgets/singleproduct.dart';
import 'package:provider/provider.dart';

class SearchProduct extends SearchDelegate<void> {

  CollectionReference _firebaseFirestore = 
    FirebaseFirestore.instance.collection("products");

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = " ";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore.snapshots().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        else {
          
          if (snapshot.data!.docs.where(
            (QueryDocumentSnapshot<Object?> element) => element['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())).isEmpty){
              return Center(child: Text("No search query found"));
            }
          else {
            return ListView(
            children: [
              ...snapshot.data!.docs.where(
                (QueryDocumentSnapshot<Object?> element) => element['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())).map((QueryDocumentSnapshot<Object?> data) {
                  final String name = data.get('name');
                  final double price = data['price'];
                  final String image = data['image'];
                  final String packing= data['packing'];
                  final String description = data['description'];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                              name: name,
                              description: description,
                              price: price,
                              image: image,
                              packing: packing),
                        ),
                      );
                    },
                    child: SingleProduct(
                        name: name,
                        price: price,
                        image: image),
                  );
                })
            ]
          );
          }


        }
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text("Search anything here"));
  }

}
