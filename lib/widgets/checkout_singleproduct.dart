import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CheckOutSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  final int index;
  final quentity;
  final double price;
  CheckOutSingleProduct({
    required this.index,
    required this.quentity,
    required this.image,
    required this.name,
    required this.price,
  });
  @override
  _CheckOutSingleProductState createState() => _CheckOutSingleProductState();
}

TextStyle myStyle = TextStyle(fontSize: 17);

class _CheckOutSingleProductState extends State<CheckOutSingleProduct> {
  late double height, width;
  Widget _buildImage() {
    return Container(
      height: height * 0.1 + 50,
      width: width * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(widget.image),
        ),
      ),
    );
  }

  Widget _buildNameAndClosePart() {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.name,
            style: TextStyle(fontSize: 15),
          ),
          // IconButton(
          //   icon: Icon(Icons.close),
          //   onPressed: () {
          //     productProvider.deleteCheckoutProduct(widget.index);
          //   },
          // ),
        ],
      ),
    );
  }

  // Widget _buildColorAndSizePart() {
  //   return Container(
  //     width: width * 0.4,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           widget.color,
  //           style: myStyle,
  //         ),
  //         Text(
  //           widget.size,
  //           style: myStyle,
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCountOrNot() {
    return Container(
      height: 35,
      width: width * 0.2 + 20,
      color: Color(0xfff2f2f2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Quantity", style: TextStyle(fontSize: 15)),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              widget.quentity.toString(),
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.2,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildImage(),
                Container(
                  height: height * 0.1 + 50,
                  width: width * 0.6,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildNameAndClosePart(),
                        //_buildColorAndSizePart(),
                        Text(
                          "\RM${widget.price.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: HexColor("#53B175"),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        _buildCountOrNot(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
