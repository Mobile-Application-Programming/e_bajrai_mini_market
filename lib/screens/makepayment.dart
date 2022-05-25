import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:http/http.dart' as http;

class MakePayment extends StatefulWidget {
  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  var url = 'https://us-central1-flutterdemo-c949a.cloudfunctions.net/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paypal'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Pay'),
          onPressed: () async {
            var request = BraintreeDropInRequest(
              tokenizationKey: 'sandbox_csnrqbwx_zp4j5w738vpbt2kj',
              collectDeviceData: true,
              paypalRequest: BraintreePayPalRequest(
                amount: '10.00',
                displayName: 'John Doe'
              ),
              cardEnabled: true
            );
            
            BraintreeDropInResult? result = 
              await BraintreeDropIn.start(request);
              if (result != null) {
                print(result.paymentMethodNonce.description);
                print(result.paymentMethodNonce.nonce);

                // final http.Response response = 
                //   await http.post(Uri.parse(
                //     "$url?payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}"
                //   ));
                
                // final payResult = jsonDecode(response.body);
                // if (payResult['result'] == 'success') print('payment done');
              }
          },
        )
      ),
    );
  }
}