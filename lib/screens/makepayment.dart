// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_braintree/flutter_braintree.dart';
// import 'package:http/http.dart' as http;

// class MakePayment extends StatefulWidget {
//   @override
//   State<MakePayment> createState() => _MakePaymentState();
// }

// class _MakePaymentState extends State<MakePayment> {
//   var url = 'https://us-central1-flutterdemo-c949a.cloudfunctions.net/';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Paypal'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Pay'),
//           onPressed: () async {
//             var request = BraintreeDropInRequest(
//               tokenizationKey: 'sandbox_csnrqbwx_zp4j5w738vpbt2kj',
//               collectDeviceData: true,
//               paypalRequest: BraintreePayPalRequest(
//                 amount: '10.00',
//                 displayName: 'John Doe'
//               ),
//               cardEnabled: true
//             );
            
//             BraintreeDropInResult? result = 
//               await BraintreeDropIn.start(request);
//               if (result != null) {
//                 print(result.paymentMethodNonce.description);
//                 print(result.paymentMethodNonce.nonce);

//                 // final http.Response response = 
//                 //   await http.post(Uri.parse(
//                 //     "$url?payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}"
//                 //   ));
                
//                 // final payResult = jsonDecode(response.body);
//                 // if (payResult['result'] == 'success') print('payment done');
//               }
//           },
//         )
//       ),
//     );
//   }
// }

import 'package:e_bajrai_mini_market/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_bajrai_mini_market/screens/paypalPayment.dart';
import 'package:hexcolor/hexcolor.dart';

class makePayment extends StatefulWidget {
  //final double totalCost;
  //makePayment({required this.totalCost});
  
  @override
  _makePaymentState createState() => _makePaymentState();
}

class _makePaymentState extends State<makePayment> {

  TextStyle style = TextStyle(fontFamily: 'Open Sans', fontSize: 15.0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          backgroundColor: HexColor("#e6e6e6"),
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: new AppBar(
              backgroundColor: Colors.white,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Payment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Open Sans'),
                  ),
                ],
              ),
            ),
          ),
          body:Container(
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 80,
                      width:350,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              HexColor("#169ffa"))),
                        onPressed: (){

                          // make PayPal payment

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => PaypalPayment(
                                onFinish: (number) async {

                                  // payment done
                                  print('order id: '+number);
                                },
                              ),
                            ),
                          );

                          
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(onPressed: (){}, icon: Icon(Icons.paypal, size: 30), color: Colors.white),
                            Text('Pay with Paypal', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18),),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              )
          ),
        )
    );
  }

}