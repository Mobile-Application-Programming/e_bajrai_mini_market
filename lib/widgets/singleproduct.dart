import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  SingleProduct({required this.name,required this.price,required this.image});
  @override
  Widget build(BuildContext context) {
    return Card(
    child: Container(
    height: 250,
    width: 170,
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                //image: AssetImage("images/$image"),
                image: NetworkImage(image),
              ),
            ),
          ),
        ),
        Text(
          "${name}",
          style: TextStyle(
            fontSize: 15
          ),
        ),
        Text(
          "\RM ${price.toStringAsFixed(2)}", 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color.fromARGB(255, 85, 94, 88)),
        ),
      ],
    ),
    ),
  );
  }
}