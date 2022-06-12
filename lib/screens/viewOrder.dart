// import 'dart:html';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';

// class OrderScreen extends StatelessWidget {
//   const OrderScreen({Key? key}) : super{key: key};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text{'Orders'},
//         backgroundColor: Colors.black,
//       ),
//       body: Columnn(
//         children: [
//           Expand(
//             child: ListView.builder{
//               itemCount: Order.orders.length,
//               itemBuilder: (BuildContent context, int index) {
//                 return OrderCard(orders: Order.orders[index]);
//               }
//             }
//           )
//         ]
//       )
//     );
//   }
// }

// class OrderCard extends StatelessWidget {
//   const OrderCard({Key? key}) : super{key: key};

//   @override
//   Widget build(BuildContext context) {
//     var products = 


//     return Padding(
//       padding: const EdgeInsets.only{
//         left:8.0,
//         right : 10,
//         top : 10,
//       },
//       child: Card(
//         margin: EdgeInserts.zero,
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,  
//               children: [
//                 Text(
//                   "Order ID: $(order.id)",
//                  style: const TextStyle{
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 },),
//                 Text(
//                   DateFormat('dd-mm-yy').format(order.createdAt),
//                  style: const TextStyle{
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 },),
//               ],
//             ),
//             const SizedBox (height: 10),
//             ListView.builder{}

//              const SizedBox (height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//               Column(children:[
//                 Text(
//                   "Delivery Fee",
//                  style: const TextStyle{
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 },),
//                 const SizedBox(height: 10),
//                 Text(
//                   "$(order.deliveryfee)",
//                  style: const TextStyle{
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 },),
//               ],),
//               Column(children:[
//                 Text(
//                   "Total",
//                  style: const TextStyle{
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 },),
//                 Text(
//                   "$(order.total)",
//                  style: const TextStyle{
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 },
//                 ),
//               ],
//               ),
//             ])
//             const SizedBus(height: 10),
//             Row(
//               MainAxisAlignment: MainAxisAlignment.spaceAround,
//               children) {
//                 ElevatedButton(
//                   onpressed: {} (), 
//                 style: ElevatedButton.styleForm{
//                   primary: Colors.black,
//                   minimumSize: const Size(150, 40)},
//                 child : Text(
//                   "Accept",
//                   style: const TextStyle {
//                     fontSize: 
//                     fontWeight: fontWeight.bold,
//                   }
//                 )
//               ),

//               ElevatedButton(onpressed: {} (), 
//                 style: ElevatedButton.styleForm(
//                   primary: Colors.black,
//                 minimumSize: const Size(150, 40)),
//                 child : Text(
//                   "Cancel",
//                   style: const TextStyle {
//                     fontSize: 
//                     fontWeight: fontWeight.bold,
//                   }
//                 )
//               )
//             }
//             ],
//           ),
//         ),
//       ),
//     )
//   }
// }