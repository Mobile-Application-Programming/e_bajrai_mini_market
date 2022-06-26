import 'package:e_bajrai_mini_market/model/orderitem.dart';
import 'package:e_bajrai_mini_market/screens/customerOrder.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DetailOrder extends StatelessWidget {
  final String orderID, orderDate, userName, userEmail, userPhoneNumber, userAddress;
  final double totalCost;
  final List<OrderItem> orderItem;
  DetailOrder(      
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order Details", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => CustomerOrder()),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0), 
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder( 
                side: BorderSide(
                  color: HexColor("#c9c9c9"),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                height: 280,
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.receipt_long, size: 30)),
                        Text(
                          "Order Information",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:10),
                    Text(
                      "Order ID: ${orderID}",
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ),
                    SizedBox(height:12),
                    Text(
                      "Order Date: ${orderDate}",
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ),
                    SizedBox(height:12),
                    Text(
                      "Name: ${userName}",
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ),
                    SizedBox(height:12),
                    Text(
                      "Email: ${userEmail}",
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ), 
                    SizedBox(height:12),
                    Text(
                      "Phone Number: ${userPhoneNumber}",
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ), 
                    SizedBox(height:12),
                    Text(
                      "Address: ${userAddress}",
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ),  
                  ],
                ),
                ),
              ),
            ),
            Card(
                shape: RoundedRectangleBorder( 
                  side: BorderSide(
                    color: HexColor("#c9c9c9"),
                  ),
                ),
                child: SizedBox(
                  //height: 550,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderItem.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 45, 
                              backgroundImage: NetworkImage(orderItem[index].image),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderItem[index].name,
                                  style: TextStyle(fontSize: 17)
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "x${orderItem[index].quantity}",
                                  style: TextStyle(fontSize: 17)
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "RM ${orderItem[index].price.toStringAsFixed(2)}",
                                  style: TextStyle(fontSize: 17)
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                )
              ),
          ],
        )
      )
    );
  }
  
}