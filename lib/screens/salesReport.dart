// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bajrai_mini_market/controller/order_controller.dart';
import 'package:e_bajrai_mini_market/controller/product_controller.dart';
import 'package:e_bajrai_mini_market/screens/homepageAdmin.dart';
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

class SalesReport extends StatefulWidget {
  //final Widget child;

  SalesReport({Key? key}) : super(key: key);

  _SalesReportState createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {

  final productController = Get.put(ProductController());
  final ProductController controller = Get.find();
  List<charts.Series<Sales, int>> _seriesLineData = [];

  Future<double> getData() async {

    controller.getAllProducts().toList();
    double totalRevenue=0;
    final productData = FirebaseFirestore.instance.collection('orders');
      final QuerySnapshot result = await productData.get();

      result.docs.forEach((res) async {
        totalRevenue += res["totalCost"];
      });
      return totalRevenue;
  }

  _generateData() async {

    String date;
    List<String> splitted;
    int day;
    int total;
    List<Sales> linesalesdata1 = [];

    final productData = FirebaseFirestore.instance.collection('orders');
      final QuerySnapshot result = await productData.get();

      for (int index=1 ; index<31 ; index++) {
        total=0;
        result.docs.forEach((res) async {
          date = res["orderDate"];
          splitted = date.split('-');
          day = int.parse(splitted[2]);

          if (day == index) {
            total += 1;
          }
        });
        linesalesdata1.add(new Sales(index, total));
      }

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.day,
        measureFn: (Sales sales, _) => sales.total,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesLineData = List<charts.Series<Sales, int>>.from(<charts.Series<Sales, int>>[]);
    _generateData();
  }

  @override
  Widget build(BuildContext context) {

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    String currentMonth = formattedDate.split('-')[1];

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => HomepageAdmin()),
                );
              },
            ),
            backgroundColor: HexColor("#53B175") ,
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff1976d2),
              tabs: [
                Tab(icon: Icon(Icons.list_alt),),
                //Tab(icon: Icon(Icons.line_axis_outlined)),
                Tab(icon: Icon(Icons.insert_chart_outlined_outlined )),
              ],
            ),
            title: Text('Sales Analytics'),
          ),
          body: FutureBuilder(
            future: FirebaseFirestore.instance.collection("orders").get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              mySnapShot = snapshot;
              totalSales = mySnapShot.data.docs.length;
              for(int i=0; i<mySnapShot.data.docs.length; i++) {
                totalRevenue += mySnapShot.data.docs[i]["totalCost"];

                if(mySnapShot.data.docs[i]["orderDate"] == formattedDate) {
                  todaySales += 1;
                  todayRevenue += mySnapShot.data.docs[i]["totalCost"];
                }
              }

              return TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                    color:Color(0xffE5E5E5),
                    child:StaggeredGridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildBox("Total Revenue", "RM ${totalRevenue.toStringAsFixed(2)}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildBox("Total Sales", totalSales.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildBox("Today Revenue", "RM ${todayRevenue.toStringAsFixed(2)}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildBox("Today Sales", todaySales.toString()),
                        ),
                      ],
                      staggeredTiles: [
                        StaggeredTile.extent(2, 150.0),
                        StaggeredTile.extent(2, 150.0),
                        StaggeredTile.extent(2, 150.0),
                        StaggeredTile.extent(2, 150.0),
                      ],
                    ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                                'Sales for this month',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                                Expanded(
                                  child: charts.LineChart(
                                    _seriesLineData,
                                    defaultRenderer: new charts.LineRendererConfig(
                                        includeArea: true, stacked: true),
                                    animate: true,
                                    animationDuration: Duration(seconds: 5),
                                    behaviors: [
                                      new charts.ChartTitle('Day',
                                          behaviorPosition: charts.BehaviorPosition.bottom,
                                          titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                                      new charts.ChartTitle('Sales',
                                          behaviorPosition: charts.BehaviorPosition.start,
                                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea),  
                                    ]
                                  ),
                                ),
                          ],
                        ),
                      ),
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

  Container _buildBox(String title, String data1) {
    return Container(
      width: 100,
      height: 100,
      child: Material(     
        color: Colors.white,
        elevation: 14.0,
        borderRadius: BorderRadius.circular(24.0),
        shadowColor: Color(0x802196F3),
        child: Center(child: 
          Padding(
            padding: EdgeInsets.all(1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      onPressed: (){}, 
                      icon: Icon(Icons.stacked_line_chart),
                      color: HexColor("#828282"),
                    ),
                    Text(title,
                    style: TextStyle(
                      fontSize: 16,
                      )
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(data1,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Sales {
  int total;
  int day;

  Sales(this.day, this.total);
}