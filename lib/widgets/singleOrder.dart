import 'package:e_bajrai_mini_market/model/orderitem.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SingleOrder extends StatelessWidget {
  final String orderID, orderDate, userName, userEmail, userPhoneNumber, userAddress;
  final double totalCost;
  final List<OrderItem> orderItem;
  SingleOrder(      
    {required this.orderID,
    required this.orderDate,
    required this.userName,
    required this.userEmail,
    required this.userPhoneNumber,
    required this.userAddress,
    required this.totalCost,
    required this.orderItem
    });

  @override
  Widget build(BuildContext context) {

    return Card(
    shape: RoundedRectangleBorder( 
      side: BorderSide(
        color: HexColor("#c9c9c9"),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
      height: 225,
      width: 170,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order ${orderDate}",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(""),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 45, 
                backgroundImage: NetworkImage(orderItem[0].image),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text(
                    orderItem[0].name,
                    style: TextStyle(fontSize: 15)
                  ),
                  SizedBox(height: 10),
                  Text(
                    "RM ${orderItem[0].price.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 15)
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(color: HexColor("#c9c9c9"), thickness: 1.5),
          SizedBox(height: 5),
          Text(
            "View details",
            style: TextStyle(
              fontSize: 15
            ),
          ),
          SizedBox(height: 5),
          Divider(color: HexColor("#c9c9c9"), thickness: 1.5),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${orderItem.length} items",
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              Text(
                "Order Total: RM ${totalCost.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 15
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    ),
  );
  }
  
}