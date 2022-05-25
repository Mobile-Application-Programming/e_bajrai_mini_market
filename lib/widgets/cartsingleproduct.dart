import 'package:flutter/material.dart';

class CartSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  final int quantity;
  final double price;
  CartSingleProduct({this.quantity, this.image, this.name, this.price});
  @override
  State<CartSingleProduct> createState() => _CartSingleProductState();
}
int count;

TextStyle myStyle = TextStyle(fontSize: 18);
class _CartSingleProductState extends State<CartSingleProduct> {
  @override
  Widget build(BuildContext context) {
    count = widget.quantity;
    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 130,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.image),
                    )
                  ),
                )
                Container(
                  height: 140,
                  width: 200,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.name,
                          style: myStyle,
                        ),
                        Text(
                          "Foods",
                          style: myStyle,
                        ),
                        Text(
                          "\$${widget.price.toString()}",
                          style: TextStyle(
                            color: Color(0xff9b96d6),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 35,
                          width: 120,
                          color: Color(0xfff2f2f2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                child: Icon(Icons.remove),
                                onTap: () {
                                  setState(() {
                                    if (count > 1)  {
                                      count--;
                                    }
                                  });
                                },
                              ),
                              Text(
                                count.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                              GestureDetector(
                                child: Icon(Icons.add),
                                onTap: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
