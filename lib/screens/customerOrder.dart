// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/controller/order_controller.dart';
import 'package:e_bajrai_mini_market/controller/product_controller.dart';
import 'package:e_bajrai_mini_market/model/orderitem.dart';
import 'package:e_bajrai_mini_market/screens/detailOrder.dart';
import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:e_bajrai_mini_market/widgets/singleOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

var mySnapShot;
double totalRevenue=0;
int totalSales=0;
double todayRevenue=0;
int todaySales=0;

class CustomerOrder extends StatefulWidget {
  //final Widget child;

  CustomerOrder({Key? key}) : super(key: key);

  _CustomerOrderState createState() => _CustomerOrderState();
}

class _CustomerOrderState extends State<CustomerOrder> {

  @override
  Widget build(BuildContext context) {

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    String currentMonth = formattedDate.split('-')[1];
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    final mailID = firebaseUser!.email;

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("#53B175"),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => HomePage()),
                );
              },
            ),
            bottom: TabBar(
              indicatorColor: Color(0xff1976d2),
              tabs: [
                Tab(text: "All Orders"),
                Tab(text: "This Month"),
                Tab(text: "Today"),
              ],
            ),
            title: Text('Order History'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('orders').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              mySnapShot = snapshot;

              return TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        ...snapshot.data!.docs.where(
                          (QueryDocumentSnapshot<Object?> element) => element['userEmail']
                          .toString()
                          .contains(mailID!)).map((QueryDocumentSnapshot<Object?> data) {
                            final String orderID = data['orderID'];
                            final String orderDate = data['orderDate'];
                            final String userName = data['userName'];
                            final String userEmail = data['userEmail'];
                            final String userPhoneNumber = data['userPhoneNumber'];
                            final String userAddress = data['userAddress'];
                            final double totalCost = data['totalCost'];
                            final List<OrderItem> orderItem = _convertOrderItems(data['orderItem']);

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => DetailOrder(orderID: orderID, orderDate: orderDate, userName: userName, userEmail: userEmail, userPhoneNumber: userPhoneNumber, userAddress: userAddress, totalCost: totalCost, orderItem: orderItem)
                                  ),
                                );
                              },
                              child: SingleOrder(orderID: orderID, orderDate: orderDate, userName: userName, userEmail: userEmail, userPhoneNumber: userPhoneNumber, userAddress: userAddress, totalCost: totalCost, orderItem: orderItem)
                            );
                          })
                      ]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        ...snapshot.data!.docs.where(
                          (QueryDocumentSnapshot<Object?> element) => element['userEmail']
                          .toString().contains(mailID!)).where(
                          (QueryDocumentSnapshot<Object?> element) => element['orderDate']
                          .toString().split('-')[1].contains(currentMonth))
                          .map((QueryDocumentSnapshot<Object?> data) {
                            final String orderID = data['orderID'];
                            final String orderDate = data['orderDate'];
                            final String userName = data['userName'];
                            final String userEmail = data['userEmail'];
                            final String userPhoneNumber = data['userPhoneNumber'];
                            final String userAddress = data['userAddress'];
                            final double totalCost = data['totalCost'];
                            final List<OrderItem> orderItem = _convertOrderItems(data['orderItem']);

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => DetailOrder(orderID: orderID, orderDate: orderDate, userName: userName, userEmail: userEmail, userPhoneNumber: userPhoneNumber, userAddress: userAddress, totalCost: totalCost, orderItem: orderItem)
                                  ),
                                );
                              },
                              child: SingleOrder(orderID: orderID, orderDate: orderDate, userName: userName, userEmail: userEmail, userPhoneNumber: userPhoneNumber, userAddress: userAddress, totalCost: totalCost, orderItem: orderItem)
                            );
                          })
                      ]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        ...snapshot.data!.docs.where(
                          (QueryDocumentSnapshot<Object?> element) => element['userEmail']
                          .toString().contains(mailID!)).where(
                          (QueryDocumentSnapshot<Object?> element) => element['orderDate']
                          .toString().contains(formattedDate))
                          .map((QueryDocumentSnapshot<Object?> data) {
                            final String orderID = data['orderID'];
                            final String orderDate = data['orderDate'];
                            final String userName = data['userName'];
                            final String userEmail = data['userEmail'];
                            final String userPhoneNumber = data['userPhoneNumber'];
                            final String userAddress = data['userAddress'];
                            final double totalCost = data['totalCost'];
                            final List<OrderItem> orderItem = _convertOrderItems(data['orderItem']);

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => DetailOrder(orderID: orderID, orderDate: orderDate, userName: userName, userEmail: userEmail, userPhoneNumber: userPhoneNumber, userAddress: userAddress, totalCost: totalCost, orderItem: orderItem)
                                  ),
                                );
                              },
                              child: SingleOrder(orderID: orderID, orderDate: orderDate, userName: userName, userEmail: userEmail, userPhoneNumber: userPhoneNumber, userAddress: userAddress, totalCost: totalCost, orderItem: orderItem)
                            );
                          })
                      ]
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

  List<OrderItem> _convertOrderItems(List orderFomDb){
    List<OrderItem> _result = [];
    if(orderFomDb.length > 0){
      orderFomDb.forEach((element) {
      _result.add(OrderItem.fromMap(element));
    });
    }
    return _result;
  }
