// import 'package:equatable/equatable.dart';

// class Order extends Equatable {
//   final String name;
//   final String description;
//   double price;
//   int quantity;
//   final String image;
//   final String categoryID;
//   final String packing;

//   const Order({
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.quantity,
//     required this.image,
//     required this.categoryID,
//     required this.packing,
//   })
// }

// Order copyWith({
//   int? id,
//   int? quantity,
//   double? price,
//   String? name,
//   String? description,
//   String? image,
//   String? categoryID,
//   String? packing,
// }) {
//   return Order{
//     id: id ?? this.id,
//     quantity: quantity ?? this.id,
//     price: price ?? this.quantity,
//     name: name ?? this.name,
//     description: description ?? this.description,
//     image: image ?? this.image,
//     packing: packing ?? this.packing,
//   };
// }

// factory Order.fromSnapshot(DocumentSnapshot snap) {
//     id: snap['id'],
//     quantity: snap['quantity'],
//     price: snap['picture'],
//     name: snap['name']
//     description: snap['description'];
//     image: snap['image'],
//     packing: pack['sakinah'];
// }


